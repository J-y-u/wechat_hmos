@Preview
@Component
struct BottomInput {

  @State
  showVoice: boolean = false // 是否显示语音输入

  build() {
    Row({ space: 10 }) {
      Image(this.showVoice ? $r("app.media.ic_public_keyboard") : $r("app.media.ic_public_sound"))
        .width(25)
        .height(25)
        .onClick(() => {
          this.showVoice = !this.showVoice
        })

      if(this.showVoice) {
        Button("按住说话")
          .type(ButtonType.Normal)
          .height(35)
          .borderRadius(2)
          .backgroundColor($r("app.color.white"))
          .fontColor($r("app.color.text_primary"))
          .layoutWeight(1)
      }else {
        TextInput()
          .height(35)
          .borderRadius(2)
          .backgroundColor($r("app.color.white"))
          .layoutWeight(1)
      }

      Image($r("app.media.ic_public_add_norm"))
        .width(25)
        .height(25)
    }
    .height(60)
    .width('100%')
    .backgroundColor($r("app.color.second_back_color"))
    .padding({
      left: 10,
      right: 10
    })

  }
}

export default BottomInput