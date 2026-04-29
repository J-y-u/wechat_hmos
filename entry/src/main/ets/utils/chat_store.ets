// 首选项的读取数据
import { preferences } from '@kit.ArkData'
import { WeChat_StoreKey, WeChat_ConnectKey, WeChat_CurrentUserKey, WeChat_UserRecordKey } from '../constant'
import { MessageInfoModel } from '../models/message'
import { CurrentUser, DefaultUserList, UserInfo } from '../models/user'

// 实现单例
export class WeChatStore {
  static context: Context
  // 获取首选项的仓库
  static getWeChatStore () {
    return preferences.getPreferencesSync(WeChatStore.context || getContext(), {
      name: WeChat_StoreKey
    })
  }
  // 获取微信联系人
  static getWeChatConnect () {
    const store = WeChatStore.getWeChatStore()
    return JSON.parse(store.getSync(WeChat_ConnectKey, JSON.stringify(DefaultUserList)) as string) as UserInfo[]
  }
  // 获取当前用户
  static getCurrentUser() {
    const store = WeChatStore.getWeChatStore()
    return JSON.parse(store.getSync(WeChat_CurrentUserKey, JSON.stringify(CurrentUser)) as string) as UserInfo
  }
  // 获取"我"和某个人的整个的聊天记录 userId 对话者的id
  // WeChat_UserRecordKey_对话者id => 所有的聊天记录
  static getWeChatMessage (userId: string) {
    const store = WeChatStore.getWeChatStore()
    return JSON.parse(store.getSync(`${WeChat_UserRecordKey}_${userId}`, "[]") as string) as MessageInfoModel[]
  }
  // 删除“我”和某个人的整个的聊天记录
  static async delWeChatMessage (userId: string) {
    const store = WeChatStore.getWeChatStore()
    store.deleteSync(`${WeChat_UserRecordKey}_${userId}`)
    await store.flush() // 写入磁盘
  }
  // 添加一条“我”和某个人的聊天记录
  static async addOneWeChatMessage (userId: string, message: MessageInfoModel) {
    const store = WeChatStore.getWeChatStore()
    const list = WeChatStore.getWeChatMessage(userId) // 拿到所有的所有的聊天记录
    list.push(message)
    // 写入list
    store.putSync(`${WeChat_UserRecordKey}_${userId}`, JSON.stringify(list))
    await store.flush() // 写入磁盘
  }
  // 删除一条“我”和某个人的聊天记录
  static async delOneWeChatMessage (userId: string, messId: string) {
    const store = WeChatStore.getWeChatStore()
    const list = WeChatStore.getWeChatMessage(userId) // 拿到所有的所有的聊天记录
    const index = list.findIndex(item => item.id === messId)
    list.splice(index, 1) // 删除
    // 写入list
    store.putSync(`${WeChat_UserRecordKey}_${userId}`, JSON.stringify(list))
    await store.flush() // 写入磁盘
  }
}