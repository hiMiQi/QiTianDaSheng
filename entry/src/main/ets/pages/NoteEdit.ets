import router from '@ohos.router'

@Entry
@Component
struct NoteEdit {
  @State title: string = ''
  @State content: string = ''
  @State createdAt: string = ''
  aboutToAppear() {
    const now = new Date();
    this.createdAt = this.formatDate(now);
  }
  formatDate(d: Date): string {
    const pad = (n: number) => (n < 10 ? '0' + n : n.toString());
    return `${pad(d.getMonth() + 1)}月${pad(d.getDate())}日 ${pad(d.getHours())}:${pad(d.getMinutes())}`;
  }
  getWordCount(text: string): number {
    return text ? text.replace(/\s/g, '').length : 0;
  }
  build() {
    Column() {
      // 顶部栏：左返回，中间撤销/重做，右确认
      Row() {
        // 左：返回
        Row() {
          Text('←')
            .fontSize(22)
            .fontColor('#444444')
        }
        .width(44)
        .height(44)
        .onClick(() => { router.replaceUrl({ url: 'pages/Index' }) })

        // 右：确认
        Row() {
          Image($r('app.media.gou'))
            .width(24)
            .height(24)
        }
        .width(44)
        .height(44)
        .onClick(() => {
          const t = this.title && this.title.trim().length > 0 ? this.title.trim() : '无标题'
          const c = this.content || ''
          router.replaceUrl({ url: 'pages/Index', params: { newNote: { title: t, content: c, createdAt: this.createdAt } } })
        })
      }
      .width('100%')
      .height(56)
      .padding({ left: 12, right: 12 })
      .justifyContent(FlexAlign.SpaceBetween)
      .border({ width: 0.5, color: '#EEEEEE' })
      .flexGrow(1)

      // 标题输入框（预设文字：标题）
      TextInput({ placeholder: '标题', text: this.title })
        .onChange((v: string) => { this.title = v })
        .width('100%')
        .fontSize(32)
        .fontWeight(FontWeight.Medium)
        .fontColor('#222222')
        .padding({ left: 16, right: 16, top: 6, bottom: 6 })
        .margin({ left: 16, right: 16, top: 16 })

      // 日期与字数（可后续按需要动态统计）
      Row() {
        Text(`${this.createdAt}  |  ${this.getWordCount(this.content)}字`)
          .fontSize(14)
          .fontColor('#A0A7AF')
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 20, bottom: 12 })


      // 正文输入框（预设文字：开始写内容~）
      TextArea({ placeholder: '开始写内容~', text: this.content })
        .onChange((v: string) => { this.content = v })
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 4, right: 4, top: 6, bottom: 6 })
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .padding({ left: 16, right: 16 })
      .margin({ left: 16, right: 16, top: 8 })

      // 底部工具栏：语音 / 图片 / 涂鸦 / 勾选 / T
      Row() {
        Image($r('app.media.wenjianjia'))
          .width(22)
          .height(22)
        Image($r('app.media.shuxie'))
          .width(22)
          .height(22)
        Image($r('app.media.daiban'))
          .width(22)
          .height(22)
        Text('T')
          .fontSize(18)
          .fontColor('#666666')
      }
      .width('100%')
      .height(64)
      .padding({ left: 24, right: 24 })
      .backgroundColor('#FFFFFF')
      .border({ width: 0.5, color: '#EEEEEE' })
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FAFAFA')
  }
}