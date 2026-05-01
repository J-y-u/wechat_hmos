import { MessageInfoModel } from '../../models/message'
import { WeChatStore } from '../../utils/chat_store'
import { router } from '@kit.ArkUI'

@Component
struct WeChat {
  @State
  list: MessageInfoModel[] = []

  aboutToAppear(): void {
    this.getAllRecord()
  }

  async getAllRecord() {
    this.list = await WeChatStore.getAllLastRecord()
  }

  // 将时间戳转化成具体时间 时间是当天的话 显示时分 如果不是当天的话 显示日期
  transTime (timeStamp: number) {
    const sendTime = new Date(timeStamp)
    if(sendTime.getDate() === new Date().getDate()) {
      // 等于今天 显示时分
      return sendTime.getHours().toString().padStart(2,"0") + ":" + sendTime.getMinutes().toString().padStart(2,"0")
    }else {
      // 显示月和日
      return (sendTime.getMonth() + 1).toString().padStart(2,"0") + "月" + sendTime.getDate().toString().padStart(2,"0") + "日"
    }
  }

  build() {
    Column() {
      Row () {
        Text("微信")
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height(50)
      List ({ space: 10 }) {
        ForEach(this.list, (item: MessageInfoModel) => {
          ListItem() {
            Row({ space: 10 }) {
              Image(item.connectUser.avatar)
                .width(50)
                .height(50)
                .borderRadius(4)
              Column() {
                Text(item.connectUser.username)
                  .fontColor($r("app.color.text_primary"))
                Text(item.messageContent)
                  .fontColor($r("app.color.text_second"))
                  .fontSize(14)
              }
              .height(50)
              .justifyContent(FlexAlign.SpaceAround)
              .alignItems(HorizontalAlign.Start)
              .padding({
                top: 4,
                bottom: 4
              })
              .layoutWeight(1)
              // 时间
              Text(this.transTime(item.sendTime))
                .fontColor($r("app.color.text_second"))
                .fontSize(14)
                .width(60)
            }
            .padding({
              left: 10,
              right: 10
            })
            .width('100%')
          }
          .width('100%')
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ChatDetail/ChatDetail',
              params: item.connectUser
            })
          })
        })
      }
      .layoutWeight(1)
      .divider({
        strokeWidth: 1,
        color: $r("app.color.back_color")
      })
    }
    .width('100%')
    .height('100%')
  }

}

export default WeChat