import { router } from '@kit.ArkUI'
import { WeChat_CurrentUserKey } from '../../constant'
import { MessageInfo, MessageInfoModel } from '../../models/message'
import { UserInfo, UserInfoModel } from '../../models/user'
import BottomInput from './Components/BottomInput'
import Message from './Components/Message'

@Entry
@Component
struct ChatDetail {

  @StorageProp(WeChat_CurrentUserKey)
  currentUser: UserInfoModel = new UserInfoModel({} as UserInfo)  // 我

  @Provide
  talkUser: UserInfoModel = new UserInfoModel({} as UserInfo)  // 你

  @State
  messList: MessageInfoModel[] = []

  aboutToAppear(): void {
    // 获取和我对话的用户的信息
    this.getTalkUser()
  }
  getTalkUser() {
    this.talkUser = router.getParams() as UserInfoModel
  }

  // 发送文本消息
  sendTextMessage (content: string) {
    // 新建消息
    let mess = new MessageInfoModel({
      messageContent: content,
      sendUser: this.currentUser, // 我发的消息
      connectUser: this.talkUser // 属于我和小趴菜的聊天记录
    } as MessageInfo)
    this.messList.push(mess) // 追加消息
  }

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
        Text(this.talkUser.username)
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

      List ({ space: 20 }) {
        ForEach(this.messList, (item: MessageInfoModel) => {
          ListItem() {
            Message({ currentMessage: item })
          }
        })
      }
      .layoutWeight(1)
      .padding({
        top: 10,
        bottom: 10
      })
      .backgroundColor($r("app.color.back_color"))

      // 底部内容
      BottomInput({
        sendTextMessage: (content: string) => {
          this.sendTextMessage(content)
        }
      })
    }
    .height('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}