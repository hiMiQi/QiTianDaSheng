import router from '@ohos.router'
import http from '@ohos.net.http'
import image from '@ohos.multimedia.image'

@Entry
@Component
struct Recipe {
  @State activeTab: string = 'dessert'
  @State imageErrorMap: Record<string, boolean> = {}
  @State remoteUrlMap: Record<string, string> = {}
  @State diagnosis: string = '热门食谱'

  desserts: Array<any> = [
    { id: 'd1', title: '巧克力蛋糕', img: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=400&h=300&fit=crop' },
    { id: 'd2', title: '草莓蛋糕', img: 'https://images.unsplash.com/photo-1565958011703-44f9829ba187?w=400&h=300&fit=crop' },
    { id: 'd3', title: '芝士蛋糕', img: 'https://images.unsplash.com/photo-1533134242443-d4fd215305ad?w=400&h=300&fit=crop' },
    { id: 'd4', title: '提拉米苏', img: 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=400&h=300&fit=crop' },
    { id: 'd5', title: '拿铁咖啡', img: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=400&h=300&fit=crop' },
    { id: 'd6', title: '抹茶拿铁', img: 'https://images.unsplash.com/photo-1515823064-d6e0c04616a7?w=400&h=300&fit=crop' }
  ]

  foods: Array<any> = [
    { id: 'f1', title: '牛排', img: 'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=400&h=300&fit=crop' },
    { id: 'f2', title: '汉堡', img: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=400&h=300&fit=crop' },
    { id: 'f3', title: '寿司', img: 'https://images.unsplash.com/photo-1562158070-57129c4368d1?w=400&h=300&fit=crop' },
    { id: 'f4', title: '沙拉', img: 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=400&h=300&fit=crop' },
    { id: 'f5', title: '意面', img: 'https://images.unsplash.com/photo-1525755662778-989d0524087e?w=400&h=300&fit=crop' },
    { id: 'f6', title: '披萨', img: 'https://images.unsplash.com/photo-1601924579621-dfce3f03f66d?w=400&h=300&fit=crop' },
  ]

  getItems(): Array<any> {
    return this.activeTab === 'dessert' ? this.desserts : this.foods
  }

  // 简单生成制作步骤（按标题定制或通用）
  makeSteps(title: string): Array<string> {
    const t = (title || '').toLowerCase();
    if (t.includes('蛋糕') || t.includes('芝士')) {
      return [
        '准备食材：面粉、鸡蛋、奶油、糖、牛奶',
        '称量并筛干料（面粉/可可粉），分离蛋黄蛋白',
        '打发黄油或蛋黄与细砂糖至蓬松发白',
        '逐次加入牛奶/香草液，搅拌',
        '拌入面粉形成细滑面糊，避免过度搅拌',
        '打发蛋白至干性发泡，分次轻柔拌入面糊',
        '倒入模具，轻震排气并抹平表面',
        '预热烤箱170-180℃，烘烤25-35分钟至表面金黄',
        '出炉倒扣放凉，脱模后修边',
        '涂抹奶油或芝士霜，装饰并切片享用'
      ];
    }
    if (t.includes('咖啡') || t.includes('拿铁')) {
      return [
        '选择咖啡豆并称重，设定研磨粗细',
        '预热咖啡机与杯具，准备萃取',
        '萃取浓缩（25-30秒，比例约1:2）',
        '蒸奶至55-65℃，形成细腻绵密奶泡',
        '敲击与拉伸奶泡，去除大气泡',
        '将浓缩倒入杯中，加入热奶与奶泡',
        '轻摇融合，表面准备拉花',
        '进行基本拉花（心形/郁金香/玫瑰）',
        '可按需调味（糖/抹茶/可可/肉桂）',
        '立即享用，并清洁设备与工作台'
      ];
    }
    if (t.includes('寿司')) {
      return [
        '淘洗寿司米并浸泡，按比例煮饭',
        '冷却后拌入米醋/糖/盐，制成寿司饭',
        '准备海苔片、鱼生或熟食、蔬菜等馅料',
        '铺海苔，均匀铺上寿司饭并留出收口边',
        '摆放馅料（鱼肉/黄瓜/牛油果等）',
        '用竹帘卷起并定型，力度均匀',
        '收口压紧，静置片刻固定形状',
        '蘸水湿刀，切段并擦拭刀面保持整洁',
        '摆盘并搭配酱油、芥末、姜片',
        '冷藏片刻口感更佳，即可食用'
      ];
    }
    // 通用版本（10步）
    return [
      '选择主要食材并备齐辅料',
      '清洗与初步处理（去皮/去根）',
      '切配（片/丝/丁），分区摆放',
      '如需腌制或焯水，提前完成预处理',
      '加热锅具，下油或预热烤箱',
      '按顺序烹调（翻炒/焖煮/烘烤/煎烙）',
      '调整火力与时间，确保熟透不糊',
      '调味（盐/糖/酱/香料）并试味微调',
      '出锅装盘，增添装饰与点缀',
      '冷却或保温，上桌享用'
    ];
  }

  switchTab(tab: string) {
    if (this.activeTab !== tab) {
      this.activeTab = tab
      this.imageErrorMap = {}
      this.remoteUrlMap = {}
    }
  }

  build() {
    Column() {
      // 顶部标题栏
      Row() {
        Text('←')
          .fontSize(22)
          .fontColor('#444')
          .onClick(() => router.back())
        Text('菜谱')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#222')
        Blank().width(30)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .border({ width: 0.5, color: '#EEE' })

      // 网络诊断
      Row() {
        Text(this.diagnosis)
          .fontSize(10)
          .fontColor('#9AA0A6')
          .layoutWeight(1)
        Button('搜索')
          .height(25)
          .width(60)
          .onClick(() => this.diagnose())
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 6, bottom: 6 })

      // 分类切换
      Row() {
        Text('甜点')
          .fontSize(16)
          .fontColor(this.activeTab === 'dessert' ? '#000' : '#888')
          .fontWeight(this.activeTab === 'dessert' ? FontWeight.Bold : FontWeight.Normal)
          .onClick(() => this.switchTab('dessert'))

        Text('美食')
          .fontSize(16)
          .fontColor(this.activeTab === 'food' ? '#000' : '#888')
          .fontWeight(this.activeTab === 'food' ? FontWeight.Bold : FontWeight.Normal)
          .margin({ left: 24 })
          .onClick(() => this.switchTab('food'))
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 12, bottom: 8 })

      // 图片列表
      Scroll() {
        Column() {
          ForEach(this.getItems(), (it: any) => {
            Column() {
              if (this.imageErrorMap[it.id]) {
                Column() {
                  Image($r('app.media.cai'))
                    .width(64)
                    .height(64)
                  Text('图片加载失败，已切换备用图')
                    .fontSize(12)
                    .fontColor('#999')
                    .margin({ top: 8 })
                }
                .width('100%')
                .height(160)
                .backgroundColor('#F3F4F6')
                .borderRadius(10)
                .alignItems(HorizontalAlign.Center)
                .justifyContent(FlexAlign.Center)
              } else {
                Image(this.remoteUrlMap[it.id] ?? it.img)
                  .width('100%')
                  .height(160)
                  .objectFit(ImageFit.Cover)
                  .borderRadius(10)
                  .onError((err) => this.retryImage(it))
                  .onComplete(() => console.info(`✅ 图片加载成功 id=${it.id}`))
              }

              Text(it.title)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .margin({ top: 8 })
            }
            .width('100%')
            .backgroundColor('#FFF')
            .border({ width: 0.5, color: '#EEE' })
            .borderRadius(12)
            .padding({ left: 12, right: 12, top: 12, bottom: 12 })
            .margin({ left: 28, right: 28, bottom: 12 })
            .onAppear(() => this.loadImage(it.id, it.img))
            .onClick(() => {
              const img = this.remoteUrlMap[it.id] ?? it.img;
              const steps = this.makeSteps(it.title);
              router.pushUrl({ url: 'pages/RecipeDetail', params: { item: { id: it.id, title: it.title, img: img }, steps: steps } });
            })
          }, (it: any) => it.id)
        }
      }
      .layoutWeight(1)

      // 底部导航
      Row() {
        Column() {
          Image($r('app.media.caidan')).width(24).height(24)
          Text('笔记').fontSize(12).fontColor('#999')
        }
        .flexGrow(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => router.replaceUrl({ url: 'pages/Index' }))

        Column() {
          Image($r('app.media.cai_active')).width(24).height(24)
          Text('菜谱').fontSize(12).fontColor('#000')
        }
        .flexGrow(1)
        .alignItems(HorizontalAlign.Center)

        Column() {
          Image($r('app.media.daiban')).width(24).height(24)
          Text('待办').fontSize(12).fontColor('#999')
        }
        .flexGrow(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => router.replaceUrl({ url: 'pages/Todo' }))
      }
      .width('100%')
      .height(72)
      .backgroundColor('#FFF')
      .border({ width: 0.5, color: '#EEE' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF')
  }

  async diagnose() {
    const client = http.createHttp()
    try {
      const res = await client.request('https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=10&h=10', {
        method: http.RequestMethod.GET,
        readTimeout: 5000,
        connectTimeout: 5000,
      })
      this.diagnosis = res.responseCode === 200 ? '网络正常 ✅' : `异常 code=${res.responseCode}`
    } catch (e) {
      this.diagnosis = '请求失败 ❌'
      console.error('diagnose error:', e)
    } finally {
      client.destroy()
    }
  }

  // ✅ 自动重试与备用图逻辑
  async retryImage(item: any, attempt: number = 1) {
    console.warn(`⚠️ 图片加载失败，准备重试（第${attempt}次） id=${item.id}`)
    if (attempt < 3) {
      setTimeout(() => {
        // 加一个随机 Unsplash 关键词备用
        const backupUrl = `${item.img}&sig=${Math.floor(Math.random() * 1000)}`
        this.remoteUrlMap = { ...this.remoteUrlMap, [item.id]: backupUrl }
      }, 500)
    } else {
      console.error(`❌ 多次重试失败 id=${item.id}`)
      this.imageErrorMap = { ...this.imageErrorMap, [item.id]: true }
    }
  }

  async loadImage(id: string, url: string) {
    if (!url || typeof url !== 'string') {
      console.error(`❌ 图片URL无效 id=${id}, url=${url}`)
      this.imageErrorMap = { ...this.imageErrorMap, [id]: true }
      return
    }

    let fixedUrl = url.trim()
    if (fixedUrl.startsWith('https:') && !fixedUrl.startsWith('https://')) {
      fixedUrl = fixedUrl.replace(/^https:/, 'https://')
    } else if (!fixedUrl.startsWith('http')) {
      console.warn(`⚠️ 异常URL已跳过 id=${id}, url=${fixedUrl}`)
      this.imageErrorMap = { ...this.imageErrorMap, [id]: true }
      return
    }

    this.remoteUrlMap = { ...this.remoteUrlMap, [id]: fixedUrl }
    console.info(`🖼️ 设置图片URL id=${id}, url=${fixedUrl}`)
  }
}
