import router from '@ohos.router'
import { addTodo } from '../store/TodoStore'

@Entry
@Component
struct TodoEdit {
  @State title: string = ''
  @State detail: string = ''
  @State createdAt: string = ''

  aboutToAppear() {
    const now = new Date();
    this.createdAt = this.formatDate(now);
  }

  formatDate(d: Date): string {
    const pad = (n: number) => (n < 10 ? '0' + n : n.toString());
    return `${pad(d.getMonth() + 1)}月${pad(d.getDate())}日 ${pad(d.getHours())}:${pad(d.getMinutes())}`;
  }

  build() {
    Column() {
      // 顶部栏：返回、确认
      Row() {
        Row() {
          Text('←')
            .fontSize(22)
            .fontColor('#444444')
        }
        .width(44)
        .height(44)
        .onClick(() => { router.replaceUrl({ url: 'pages/Todo' }) })

        Row() {}
        .layoutWeight(1)

        Row() {
          Image($r('app.media.gou'))
            .width(24)
            .height(24)
        }
        .width(44)
        .height(44)
        .onClick(() => {
          const t = this.title && this.title.trim().length > 0 ? this.title.trim() : '待办'
          const d = this.detail || ''
          addTodo({ title: t, detail: d, createdAt: this.createdAt, done: false })
          router.replaceUrl({ url: 'pages/Todo' })
        })
      }
      .width('100%')
      .height(56)
      .padding({ left: 12, right: 12 })
      .border({ width: 0.5, color: '#EEEEEE' })

      // 标题输入
      TextInput({ placeholder: '待办标题', text: this.title })
        .onChange((v: string) => { this.title = v })
        .width('100%')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor('#222222')
        .padding({ left: 16, right: 16, top: 6, bottom: 6 })
        .margin({ left: 16, right: 16, top: 16 })

      // 日期
      Row() {
        Text(`${this.createdAt}`)
          .fontSize(14)
          .fontColor('#A0A7AF')
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 10, bottom: 12 })

      // 详情输入
      TextArea({ placeholder: '补充说明（可选）', text: this.detail })
        .onChange((v: string) => { this.detail = v })
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 4, right: 4, top: 6, bottom: 6 })
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .padding({ left: 16, right: 16 })
      .margin({ left: 16, right: 16, top: 8 })

      // 底部工具栏（占位）
      Row() {
        Text('添加完成后返回待办列表')
          .fontSize(14)
          .fontColor('#666666')
      }
      .width('100%')
      .height(64)
      .padding({ left: 24, right: 24 })
      .backgroundColor('#FFFFFF')
      .border({ width: 0.5, color: '#EEEEEE' })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FAFAFA')
  }
}