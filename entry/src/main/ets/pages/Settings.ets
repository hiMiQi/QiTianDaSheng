import router from '@ohos.router'

@Entry
@Component
struct Settings {
  // 显示
  @State darkMode: boolean = false
  @State listDensity: string = 'comfortable' // comfortable | compact
  @State fontSize: string = 'medium' // small | medium | large

  // 笔记
  @State sortOrder: string = 'date' // date | title
  @State showWordCount: boolean = true
  @State autoSave: boolean = true
  @State autoSaveInterval: string = '30s' // 15s | 30s | 60s

  // 快捷
  @State showQuickAdd: boolean = true
  @State defaultNotebook: string = ''

  // 隐私
  @State enableLock: boolean = false

  build() {
    Column() {
      // 顶部栏：返回 + 标题
      Row() {
        Row() {
          Text('←')
            .fontSize(22)
            .fontColor('#444')
        }
        .width(44)
        .height(44)
        .onClick(() => router.back())

        Text('设置')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#222')

        Row() {}
        .width(44)
        .height(44)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .border({ width: 0.5, color: '#EEE' })

      // 显示设置
      Column() {
        Text('显示')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 8 })
        // 深色模式
        Row() {
          Text('深色模式')
            .fontSize(16)
            .layoutWeight(1)
          Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
            .onChange((v: boolean) => { this.darkMode = v; console.info(`Setting darkMode=${v}`) })
        }
        .padding({ top: 12, bottom: 12 })
        .border({ width: 0.5, color: '#EEE' })
        .borderRadius(10)

        // 列表密度
        Row() {
          Text('列表密度')
            .fontSize(16)
            .layoutWeight(1)
          Radio({ value: 'comfortable', group: 'listDensity' })
            .checked(this.listDensity === 'comfortable')
            .onChange((v: boolean) => { if (v) { this.listDensity = 'comfortable'; console.info('Setting listDensity=comfortable') } })
          Text('舒适')
            .fontSize(16)
            .margin({ right: 12 })
          Radio({ value: 'compact', group: 'listDensity' })
            .checked(this.listDensity === 'compact')
            .onChange((v: boolean) => { if (v) { this.listDensity = 'compact'; console.info('Setting listDensity=compact') } })
          Text('紧凑')
            .fontSize(16)
        }
        .padding({ top: 12, bottom: 12 })
        .border({ width: 0.5, color: '#EEE' })
        .borderRadius(10)

        // 字体大小
        Row() {
          Text('字体大小')
            .fontSize(16)
            .layoutWeight(1)
          Radio({ value: 'small', group: 'fontSize' })
            .checked(this.fontSize === 'small')
            .onChange((v: boolean) => { if (v) { this.fontSize = 'small'; console.info('Setting fontSize=small') } })
          Text('小')
            .fontSize(16)
            .margin({ right: 12 })
          Radio({ value: 'medium', group: 'fontSize' })
            .checked(this.fontSize === 'medium')
            .onChange((v: boolean) => { if (v) { this.fontSize = 'medium'; console.info('Setting fontSize=medium') } })
          Text('中')
            .fontSize(16)
            .margin({ right: 12 })
          Radio({ value: 'large', group: 'fontSize' })
            .checked(this.fontSize === 'large')
            .onChange((v: boolean) => { if (v) { this.fontSize = 'large'; console.info('Setting fontSize=large') } })
          Text('大')
            .fontSize(16)
        }
        .padding({ top: 12, bottom: 12 })
        .border({ width: 0.5, color: '#EEE' })
        .borderRadius(10)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 12 })

      // 笔记设置
      Column() {
        Text('笔记')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 8 })
        // 默认排序
        Row() {
          Text('默认排序')
            .fontSize(16)
            .layoutWeight(1)
          Radio({ value: 'date', group: 'sortOrder' })
            .checked(this.sortOrder === 'date')
            .onChange((v: boolean) => { if (v) { this.sortOrder = 'date'; console.info('Setting sortOrder=date') } })
          Text('按日期')
            .fontSize(16)
            .margin({ right: 12 })
          Radio({ value: 'title', group: 'sortOrder' })
            .checked(this.sortOrder === 'title')
            .onChange((v: boolean) => { if (v) { this.sortOrder = 'title'; console.info('Setting sortOrder=title') } })
          Text('按标题')
            .fontSize(16)
        }
        .padding({ top: 12, bottom: 12 })
        .border({ width: 0.5, color: '#EEE' })
        .borderRadius(10)

        // 显示字数
        Row() {
          Text('显示字数')
            .fontSize(16)
            .layoutWeight(1)
          Toggle({ type: ToggleType.Switch, isOn: this.showWordCount })
            .onChange((v: boolean) => { this.showWordCount = v; console.info(`Setting showWordCount=${v}`) })
        }
        .padding({ top: 12, bottom: 12 })
        .border({ width: 0.5, color: '#EEE' })
        .borderRadius(10)

        // 自动保存
        Row() {
          Text('自动保存')
            .fontSize(16)
            .layoutWeight(1)
          Toggle({ type: ToggleType.Switch, isOn: this.autoSave })
            .onChange((v: boolean) => { this.autoSave = v; console.info(`Setting autoSave=${v}`) })
        }
        .padding({ top: 12, bottom: 12 })
        .border({ width: 0.5, color: '#EEE' })
        .borderRadius(10)

        // 保存间隔
        Row() {
          Text('保存间隔')
            .fontSize(16)
            .layoutWeight(1)
          Radio({ value: '15s', group: 'autoSaveInterval' })
            .checked(this.autoSaveInterval === '15s')
            .onChange((v: boolean) => { if (v) { this.autoSaveInterval = '15s'; console.info('Setting autoSaveInterval=15s') } })
          Text('15秒')
            .fontSize(16)
            .margin({ right: 12 })
          Radio({ value: '30s', group: 'autoSaveInterval' })
            .checked(this.autoSaveInterval === '30s')
            .onChange((v: boolean) => { if (v) { this.autoSaveInterval = '30s'; console.info('Setting autoSaveInterval=30s') } })
          Text('30秒')
            .fontSize(16)
            .margin({ right: 12 })
          Radio({ value: '60s', group: 'autoSaveInterval' })
            .checked(this.autoSaveInterval === '60s')
            .onChange((v: boolean) => { if (v) { this.autoSaveInterval = '60s'; console.info('Setting autoSaveInterval=60s') } })
          Text('60秒')
            .fontSize(16)
        }
        .padding({ top: 12, bottom: 12 })
        .border({ width: 0.5, color: '#EEE' })
        .borderRadius(10)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 12 })

      // 快捷设置
      Column() {
        Text('快捷')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 8 })
        Row() {
          Text('显示快速添加按钮')
            .fontSize(16)
            .layoutWeight(1)
          Toggle({ type: ToggleType.Switch, isOn: this.showQuickAdd })
            .onChange((v: boolean) => { this.showQuickAdd = v; console.info(`Setting showQuickAdd=${v}`) })
        }
        .padding({ top: 12, bottom: 12 })
        .border({ width: 0.5, color: '#EEE' })
        .borderRadius(10)

        Row() {
          Text('默认分类（可选）')
            .fontSize(16)
            .layoutWeight(1)
        }
        .padding({ top: 8 })
        TextInput({ placeholder: '例如：学习、生活', text: this.defaultNotebook })
          .onChange((v: string) => { this.defaultNotebook = v })
          .width('100%')
          .fontSize(16)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .border({ width: 0.5, color: '#EEE' })
          .borderRadius(8)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 12 })

      // 隐私
      Column() {
        Text('隐私')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 8 })
        Row() {
          Text('启用应用锁（占位）')
            .fontSize(16)
            .layoutWeight(1)
          Toggle({ type: ToggleType.Switch, isOn: this.enableLock })
            .onChange((v: boolean) => { this.enableLock = v; console.info(`Setting enableLock=${v}`) })
        }
        .padding({ top: 12, bottom: 12 })
        .border({ width: 0.5, color: '#EEE' })
        .borderRadius(10)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 12 })

      // 存储与备份
      Column() {
        Text('存储与备份')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 8 })
        Row() {
          Button('导出备份')
            .type(ButtonType.Capsule)
            .height(36)
            .onClick(() => { console.warn('导出备份：当前为占位操作'); })
          Button('导入备份')
            .type(ButtonType.Capsule)
            .height(36)
            .margin({ left: 12 })
            .onClick(() => { console.warn('导入备份：当前为占位操作'); })
        }
        .padding({ top: 12 })

        Row() {
          Button('清除缓存')
            .type(ButtonType.Capsule)
            .height(36)
            .onClick(() => { console.warn('清除缓存：当前为占位操作'); })
        }
        .padding({ top: 8 })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 12 })
      .layoutWeight(1)

      // 底部：关于
      Column() {
        Text('关于 FanQue')
          .fontSize(12)
          .fontColor('#9AA0A6')
        Text('版本 0.1.0')
          .fontSize(12)
          .fontColor('#9AA0A6')
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}