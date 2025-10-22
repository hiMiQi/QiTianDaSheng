import router from '@ohos.router'
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct Login {
  @State account: string = ''
  @State password: string = ''

  build() {
    Column() {
      // 顶部品牌区
      Column() {
        Image($r('app.media.RestCloud'))
          .width(96)
          .height(96)
          .margin({ bottom: 24 })
        Text('小栖云 RestCloud')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor('#222')
      }
      .width('100%')
      .padding({ top: 100 })
      .alignItems(HorizontalAlign.Center)

      // 登录表单
      Column() {
        // 账号
        Row() {
          Image($r('app.media.user'))
            .width(16)
            .height(16)
            .margin({ left: 12, right: 8 })
          TextInput({ placeholder: '手机号 / 邮箱' })
            .height(40)
            .backgroundColor('#00000000')
            .borderRadius(20)
            .fontSize(14)
            .flexGrow(1)
            .onChange((v: string) => { this.account = v })
        }
        .width('88%')
        .height(48)
        .backgroundColor('#F5F6F7')
        .borderRadius(24)
        .alignItems(VerticalAlign.Center)
        .padding({ left: 16, right: 16 })
        .margin({ top: 24 })
        .alignSelf(ItemAlign.Center)

        // 密码
        Row() {
          Image($r('app.media.password'))
            .width(18)
            .height(18)
            .margin({ left: 12, right: 8 })
          TextInput({ placeholder: '密码' })
            .height(40)
            .width(20)
            .backgroundColor('#00000000')
            .borderRadius(20)
            .fontSize(14)
            .flexGrow(1)
            .type(InputType.Password)
            .onChange((v: string) => { this.password = v })
        }
        .width('88%')
        .height(48)
        .backgroundColor('#F5F6F7')
        .borderRadius(24)
        .alignItems(VerticalAlign.Center)
        .padding({ left: 16, right: 16 })
        .margin({ top: 14 })
        .alignSelf(ItemAlign.Center)

        // 登录按钮
        Button('登录')
          .type(ButtonType.Capsule)
          .height(48)
          .width('88%')
          .margin({ top: 24 })
          .backgroundColor('#00000000')
          .linearGradient({ angle: 12, colors: [['#0097FF', 0.0], ['#00C4FF', 0.5], ['#2EE6A6', 1.0]] })
          .fontColor('#FFFFFF')
          .onClick(() => {
            const acc = this.account.trim();
            const pwd = this.password.trim();
            if (acc === 'admin' && pwd === 'admin') {
              AppStorage.SetOrCreate('loggedIn', true);
              router.replaceUrl({ url: 'pages/Index' })
            } else {
              promptAction.showDialog({
                title: '登录失败',
                message: '账号或密码错误',
                buttons: [ { text: '确定', color: '#3B82F6' } ]
              })
            }
          })

        // 辅助链接
        Row() {
          Text('忘记密码')
            .fontSize(12)
            .fontColor('#888')
          Text('注册')
            .fontSize(12)
            .fontColor('#00C4FF')
            .margin({ left: 18 })
        }
        .width('88%')
        .margin({ top: 12 })
        .alignSelf(ItemAlign.Center)
        .justifyContent(FlexAlign.End)
      }
      .layoutWeight(1)
       .margin({ top: 32 })

      // 底部导航：返回或跳过登录
      Row() {
        Button('跳过，稍后登录')
          .type(ButtonType.Capsule)
          .height(36)
          .width('88%')
          .backgroundColor('#FFFFFF')
          .fontColor('#3B82F6')
          .borderRadius(24)
          .borderColor('#3B82F6')
          .borderWidth(1)
          .onClick(() => {
            AppStorage.SetOrCreate('loggedIn', false);
            router.replaceUrl({ url: 'pages/Index' })
          })
      }
      .width('100%')
      .height(72)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}