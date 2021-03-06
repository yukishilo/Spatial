import UIKit
import Spatial
/**
 * Create
 */
extension VC{
   /**
    * Creates main view
    */
   func createMainView() -> MainView{
      let view:MainView = MainView()
      self.view.addSubview(view)
      view.anchorAndSize(to: self.view)
      return view
   }
   /**
    * Creates animation test view
    */
   func createAnimTestView() -> AnimationTest{
      let view:AnimationTest = AnimationTest.init(frame: CGRect.init(origin: .zero, size: .zero))
      self.view.addSubview(view)
      view.anchorAndSize(to: self.view)
      return view
   }
}
