import router from '@ohos.router'
import { getTodos, toggleDone } from '../store/TodoStore'
@Entry
@Component
struct Index {
  @State todos: Array<any> = []
  aboutToAppear() {
    this.todos = getTodos();
  }
  build() {
    Column() {
      // 顶部图标独立置顶（右侧）
      Row() {
        Image($r('app.media.shezhi'))
          .width(24)
          .height(24)
          .onClick(() => router.pushUrl({ url: 'pages/Settings' }))
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 12, bottom: 0 })
      .justifyContent(FlexAlign.End)

      // 标题单独一行
      Row() {
        Text('待办')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 8, bottom: 8 })

      // 主内容区：有数据则展示列表，否则空态
      if (this.todos.length === 0) {
        Column() {
          Image($r('app.media.xie'))
            .width(100)
            .height(100)
            .opacity(0.9)
            .margin({ left: 22 })
          Text('没有待办')
            .fontSize(18)
            .fontColor('#9AA0A6')
            .margin({ top: 12, right: 2 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
      } else {
        Scroll() {
          Column() {
            ForEach(this.todos, (t: any, i: number) => {
              Column() {
                Row() {
                  Text(t.done ? '✓' : '○')
                    .fontSize(20)
                    .fontColor(t.done ? '#4CAF50' : '#CCCCCC')
                    .margin({ right: 8 })
                    .onClick(() => {
                      toggleDone(i)
                      this.todos = getTodos()
                    })
                  Text(t.title || '待办')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(t.done ? '#A0A7AF' : '#222222')
                  Blank().layoutWeight(1)
                  Text(t.createdAt || '')
                    .fontSize(12)
                    .fontColor('#A0A7AF')
                }
                .width('100%')
                .padding({ left: 12, right: 12, top: 10, bottom: 6 })

                if (t.detail) {
                  Text(t.detail)
                    .fontSize(14)
                    .fontColor(t.done ? '#AAAAAA' : '#444444')
                    .padding({ left: 12, right: 12, bottom: 10 })
                }
              }
              .width('100%')
              .backgroundColor(t.done ? '#F7F7F7' : '#FFFFFF')
              .borderRadius(12)
              .margin({ left: 16, right: 16, top: 8 })
              .border({ width: 0.5, color: '#EEEEEE' })
            })
          }
          .width('100%')
        }
        .width('100%')
        .layoutWeight(1)
      }

      // 悬浮添加按钮：位于底部导航上方，右下角
      Row() {
        Image($r('app.media.tianjia'))
          .width(64)
          .height(64)
          .onClick(() => {
            router.pushUrl({ url: 'pages/TodoEdit' })
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)

      // 底部导航：笔记 / 菜谱 / 待办（固定在最底部）
      Row() {
        Column() {
          Image($r('app.media.caidan'))
            .width(24)
            .height(24)
          Text('笔记')
            .fontSize(12)
            .fontColor('#999999')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .flexGrow(1)
        .onClick(() => {
          router.pushUrl({ url: 'pages/Index' })
        })
      
        // 中间：菜谱
        Column() {
          Image($r('app.media.cai'))
            .width(24)
            .height(24)
          Text('菜谱')
            .fontSize(12)
            .fontColor('#999999')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .flexGrow(1)
        .onClick(() => { router.replaceUrl({ url: 'pages/Recipe' }) })
      
        Column() {
          Image($r('app.media.daiban_active'))
            .width(24)
            .height(24)
          Text('待办')
            .fontSize(12)
            .fontColor('#000000')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .flexGrow(1)
      }
      .width('100%')
      .height(72)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}