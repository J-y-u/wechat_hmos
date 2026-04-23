export interface UserInfo {
  username: string // 用户名
  user_id: string // 用户标识
  avatar: string // 头像字段
}

export class UserInfoModel implements UserInfo {
  username: string = ''
  user_id: string = ""
  avatar: string = ''

  constructor(model: UserInfo) {
    this.username = model.username
    this.user_id = model.user_id
    this.avatar = model.avatar
  }
}

// 默认用户 如果读取不到 就用默认用户
export const DefaultUserList: UserInfo[] = [{
  username: '小趴菜',
  avatar: 'https://img2.baidu.com/it/u=2778471297,524433918&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
  user_id: '1'
},{
  username: '老板',
  avatar: 'https://robohash.org/boss?set=set2&size=200x200',
  user_id: '2'
},{
  username: '老婆',
  avatar: 'https://robohash.org/wife?set=set2&size=200x200',
  user_id: '3'
},{
  username: '物业小张',
  avatar: 'https://robohash.org/zhang?set=set3&size=200x200',
  user_id: '4'
},{
  username: '水若寒宇',
  avatar: 'https://robohash.org/test1?set=set4&size=200x200',
  user_id: '5'
},{
  username: '小林',
  avatar: 'https://robohash.org/test2?set=set4&size=200x200',
  user_id: '6'
},{
  username: '花开富贵',
  avatar: 'https://robohash.org/test3?set=set4&size=200x200',
  user_id: '7'
},{
  username: '妈妈',
  avatar: 'https://robohash.org/test4?set=set4&size=200x200',
  user_id: '8'
},{
  username: '沧海一生笑',
  avatar: 'https://ui-avatars.com/api/?name=John+Doe&size=500&background=4F46E5&color=fff',
  user_id: '9'
},{
  username: '爱哭的燕子🦋🦋',
  avatar: 'https://robohash.org/test5?set=set4&size=200x200',
  user_id: '10'
}]
