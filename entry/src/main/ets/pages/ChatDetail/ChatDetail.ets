import { router } from '@kit.ArkUI'

@Entry
@Component
struct ChatDetail {

  build() {
    Column() {
      Stack ({
        alignContent: Alignment.Start
      }) {
        Image($r("app.media.ic_public_arrow_left"))
          .width(30)
          .height(30)
          .zIndex(2) // 让图像层级大于文本，不至于点击事件被覆盖
          .onClick(() => {
            router.back()
          })
        Text("小果果")
          .fontColor($r("app.color.text_primary"))
          .width('100%')
          .textAlign(TextAlign.Center)
      }
      .padding({
        left: 10,
        right: 10
      })
      .height(50)
      .width("100%")
    }
  }
}