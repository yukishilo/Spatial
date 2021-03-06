#if os(iOS)
import UIKit
/**
 * Distribute items horizontally or vertically
 */
extension Constraint {
   /**
    * Horizontal & Vertical Distribution
    * - TODO: ⚠️️ Add support for spacing
    * - TODO: ⚠️️ Add support for alignTo: (because you might want to set a different anchor for the views than for the view to align to)
    * - TODO: ⚠️️ parent is always superview, then we must use UIView as type, remember your returning constriants, not setting actual anchor or size, you do that in activeConstraint
    * - IMPORTANT: ⚠️️ Sets only anchors not sizes
    * ## EXAMPLE:
    * [label1,label2,label3].applyAnchorsAndSizes { views in
    *      let anchors = Constraint.distribute(vertically:views,align:.left)
    *      let sizes = views.map{ Constraint.size($0, toView: self.frame.width, height: 48)) }
    *      return (anchors, sizes)
    * }
    * - NOTE: Alternativly you can do: views.enumerated().map{Constraint.anchor($0.1, to: self, align: .topLeft, alignTo:.topLeft,offset:CGPoint(x:0,y:48 * $0.0))} etc
    */
   public static func distribute(horizontally views:[UIView], align:Alignment = .topLeft, spacing:CGFloat = 0, offset:CGFloat = 0) -> [AnchorConstraint] {
      let xConstraints:[NSLayoutConstraint] = distribute(views, axis:.horizontal, align:align, spacing:spacing, offset:offset)
      let yConstraints:[NSLayoutConstraint] = views.map{ view in
         guard let superView = view.superview else {fatalError("View must have superview")}
         return Constraint.anchor(view, to: superView, align: align.verAlign, alignTo: align.verAlign)}
      let anchors:[AnchorConstraint] = Array(zip(xConstraints,yConstraints))
      return anchors
   }
   /**
    * - IMPORTANT ⚠️️ Sets only anchors not sizes
    */
   public static func distribute(vertically views:[UIView], align:Alignment = .topLeft, spacing:CGFloat = 0, offset:CGFloat = 0) -> [AnchorConstraint] {
      let xConstraints:[NSLayoutConstraint] = views.map{ view in
         guard let superView = view.superview else {fatalError("View must have superview")}
         return Constraint.anchor(view, to: superView, align: align.horAlign, alignTo: align.horAlign)
      }
      let yConstraints = distribute(views, axis:.vertical, align:align, spacing:spacing, offset:offset)
      let anchors:[AnchorConstraint] = Array(zip(xConstraints,yConstraints))
      return anchors
   }
}
/**
 * Internal helper methods
 * - NOTE: Consider moving to fileprivate Util class
 */
extension Constraint{
   /**
    * Distributes vertically or horizontally
    */
   fileprivate static func distribute(_ views:[UIView], axis:Axis, align:Alignment, spacing:CGFloat = 0, offset:CGFloat = 0) -> [NSLayoutConstraint]{
      switch (align.horAlign, align.verAlign) {
      case (.left, _),(_ , .top): return distribute(fromStart:views, axis:axis, spacing:spacing, offset:offset)
      case (.right, _),(_ , .bottom): return distribute(fromEnd:views, axis:axis, spacing:spacing, offset:offset)
      default: fatalError("Center not supported")
      }
   }
   /**
    * Distributes from start to end
    */
   fileprivate static func distribute(fromStart views:[UIView], axis:Axis, spacing:CGFloat = 0, offset:CGFloat = 0) -> [NSLayoutConstraint] {
      var anchors:[NSLayoutConstraint] = []
      var prevView:UIView?
      views.enumerated().forEach { (_,view) in
         guard let toView:UIView = prevView ?? view.superview else {fatalError("View must have superview")}
         let offset = prevView == nil ? offset : 0/*only the first view gets offset*/
         let spacing:CGFloat = prevView != nil ? spacing : 0/*all subsequent views gets spacing*/
         switch axis {
         case .horizontal:
            let alignTo:HorizontalAlign = prevView == nil ? .left : .right/*first align to left pf superView, then right of each subsequent item*/
            anchors.append(Constraint.anchor(view,to:toView,align:.left,alignTo:alignTo,offset:offset + spacing))
         case.vertical:
            let alignTo:VerticalAlign = prevView == nil ? .top : .bottom/*first align to top pf superView, then bottom of each subsequent item*/
            anchors.append(Constraint.anchor(view, to:toView, align:.top, alignTo:alignTo, offset:offset + spacing))
         }
         prevView = view
      }
      return anchors
   }
   /**
    * Aligns from end to start
    */
   fileprivate static func distribute(fromEnd views:[UIView], axis:Axis, spacing:CGFloat = 0, offset:CGFloat) -> [NSLayoutConstraint] {
      var anchors:[NSLayoutConstraint] = []
      var prevView:UIView?
      for view in views.reversed() {/*Move backwards*/
         guard let toView:UIView = prevView ?? view.superview else {fatalError("View must have superview")}
         let offset = prevView == nil ? offset : 0
         let spacing:CGFloat = prevView != nil ? spacing : 0 /*All subsequent views gets spacing*/
         switch axis {
         case .horizontal:
            let alignTo:HorizontalAlign = prevView == nil ? .right : .left/*first align to right pf superView, then left of each subsequent item*/
            anchors.append(Constraint.anchor(view,to:toView,align:.right,alignTo:alignTo,offset:offset + spacing))
         case.vertical:
            let alignTo:VerticalAlign = prevView == nil ? .bottom : .top/*first align to bottom pf superView, then top of each subsequent item*/
            anchors.append(Constraint.anchor(view,to:toView,align:.bottom,alignTo:alignTo,offset:offset + spacing))
         }
         prevView = view
      }
      return anchors
   }
}
#endif
