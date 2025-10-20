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
        '准备食材：面粉、鸡蛋、奶油、糖',
        '混合搅拌至顺滑，倒入模具',
        '预热烤箱，180℃烘烤25-35分钟',
        '取出放凉，涂抹奶油并装饰',
        '切片享用'
      ];
    }
    if (t.includes('咖啡') || t.includes('拿铁')) {
      return [
        '研磨咖啡豆，准备浓缩咖啡',
        '打发牛奶形成细腻奶泡',
        '倒入浓缩，再加入奶泡',
        '调味（糖/抹茶/可可）并拉花',
        '趁热享用'
      ];
    }
    if (t.includes('寿司')) {
      return [
        '准备寿司米，煮熟后拌入米醋',
        '切片生鱼/蔬菜等配料',
        '铺米、放料、卷紧成卷',
        '切段装盘，配酱油芥末',
        '冷藏片刻更佳'
      ];
    }
    // 通用版本
    return [
      '准备并清洗主要食材',
      '切片/切块完成基础处理',
      '加热/烘焙直至熟透',
      '调味并摆盘',
      '冷却或保温，上桌'
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
            .margin({ left: 20, right: 20, bottom: 12 })
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
          Image($r('app.media.wenjianjia')).width(24).height(24)
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
