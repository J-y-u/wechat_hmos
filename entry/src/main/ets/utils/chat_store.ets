// 首选项的读取数据
import { preferences } from '@kit.ArkData'
import { WeChat_StoreKey, WeChat_ConnectKey, WeChat_CurrentUserKey } from '../constant'
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
}