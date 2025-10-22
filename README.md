# 小栖云 RestCloud 开发文档

## 项目概览
- 名称：小栖云 RestCloud（HarmonyOS / ArkTS）
- 目标：提供笔记、菜谱、待办与个人中心的轻量化体验
- 技术栈：ArkTS、HarmonyOS UI、DevEco Studio、Hvigor 构建
- 代码根目录：`c:\Users\white\DevEcoStudioProjects\FanQue`

## 目录结构
- 页面代码：`entry/src/main/ets/pages/`
  - `Index.ets` 首页与底部导航
  - `Mine.ets` 我的中心（登录信息、设置、退出）
  - `Login.ets` 登录页（账号密码输入、登录/跳过）
  - 其他页面：`Recipe.ets`、`Todo.ets`（如存在）
- 资源：`entry/src/main/resources/base/media/`
  - 图标示例：`mine.png`、`mine_active.png`、`cai.png`、`cai_active.png`、`daiban.png`、`daiban_active.png` 等
- 构建配置：
  - `hvigorw.bat`（Windows 构建入口）
  - `hvigorfile.ts`（模块构建配置）
  - `build-profile.json5`（构建与签名配置）

## 路由与页面
- 路由 API：`@ohos.router`
  - 保留栈：`router.pushUrl({ url: 'pages/XXX' })`
  - 替换栈：`router.replaceUrl({ url: 'pages/XXX' })`
- 页面示例：
  - 首页底部导航中的“我的”入口：
    - `Index.ets` → `router.pushUrl({ url: 'pages/Mine' })`
  - 我的页底部导航（当前页高亮）：
    - 图标：`$r('app.media.mine_active')`
    - 文字颜色：`'#36C7F3'`

## 状态管理
- 会话内持久：`AppStorage` + `@StorageLink`
  - 声明（跨页共享）：
    - `@StorageLink('loggedIn') loggedIn: boolean = false`
  - 更新：
    - 登录成功：`AppStorage.SetOrCreate('loggedIn', true)`
    - 退出登录：`AppStorage.SetOrCreate('loggedIn', false)`
- 页面对接：
  - `Index.ets` 使用 `@StorageLink('loggedIn')`，移除路由参数依赖
  - `Mine.ets` 使用 `@StorageLink('loggedIn')`，按钮退出后跳转登录页
  - `Login.ets` 登录成功后设置 `loggedIn=true` 并返回首页
- 可选增强（重启后仍记住登录状态）：
  - 使用 `@ohos.data.preferences` 将登录态写入偏好，并在应用启动时同步到 `AppStorage`

## 登录与退出
- 登录页：`entry/src/main/ets/pages/Login.ets`
  - 示例凭据：`admin/admin`
  - 成功逻辑：
    ```ts
    if (acc === 'admin' && pwd === 'admin') {
      AppStorage.SetOrCreate('loggedIn', true);
      router.replaceUrl({ url: 'pages/Index' });
    }
    ```
  - 跳过登录：
    ```ts
    AppStorage.SetOrCreate('loggedIn', false);
    router.replaceUrl({ url: 'pages/Index' });
    ```
- 我的页退出：`entry/src/main/ets/pages/Mine.ets`
  ```ts
  AppStorage.SetOrCreate('loggedIn', false);
  router.replaceUrl({ url: 'pages/Login' });
  ```

## 资源与样式
- 资源引用：`$r('app.media.xxx')`
- 激活态规范：
  - 当前页面的底部图标使用 `*_active.png`
  - 文本颜色使用主色：`'#36C7F3'`
- 常用颜色：
  - 主色：`'#36C7F3'`
  - 文本：深色 `'#333333'`、次级 `'#999999'`、白色 `'#FFFFFF'`
  - 分割线：`'#EEEEEE'`
- 渐变示例（登录按钮）：
  ```ts
  .linearGradient({ angle: 12, colors: [['#0097FF', 0.0], ['#00C4FF', 0.5], ['#2EE6A6', 1.0]] })
  ```

## 构建与运行
- 构建命令（Windows）：
  - 在项目根目录执行：
    ```
    ./hvigorw.bat assembleHap -p entry
    ```
- 构建提示：
  - 若未配置签名，会看到跳过签名的警告；正式打包需在 `build-profile.json5` 配置 `signingConfigs`
- 运行：
  - 在 DevEco Studio 中选择模拟器或真机运行调试

## 测试清单
- 登录流程：
  - 输入 `admin/admin` → 跳转首页 → 进入“我的”显示头像与账号ID
  - 返回首页再进入“我的”，登录态不丢失（会话内）
- 退出登录：
  - 在“我的”点击“退出登录”→ 跳转到登录页
  - 再次进入“我的”，应显示未登录视图
- 底部导航激活态：
  - 进入各页面时，该页面底部图标使用对应 `*_active.png`，文字高亮
- 交互反馈：
  - 登录失败弹窗：`promptAction.showDialog`
  - 列表项点击反馈：`promptAction.showToast`

## 编码规范
- 命名：
  - 组件：大驼峰（`Login`、`Mine`）
  - 状态：小驼峰（`loggedIn`、`selectedCategory`）
- 布局与对齐：
  - 容器：`Column` / `Row`
  - 对齐：`alignItems`、`justifyContent`、`layoutWeight`、`alignSelf`
- 路由使用：
  - 优先通过 `AppStorage` 共享跨页状态，减少路由参数耦合

## 常见开发任务
- 新增底部 Tab：
  - 新建页面并在 `media` 添加 `xxx.png` 和 `xxx_active.png`
  - 在各页面底部导航中增加对应 `Column`，当前页使用激活图标与文字高亮
- 新增“我的”列表项：
  - 在 `Mine.ets` 中部白卡片内新增 `Row()`，保持统一高度、内边距与分割线样式
- UI 微调：
  - 信息卡高度与间距如：`.height(180)`、`.padding({ left: 20, right: 20, top: 24, bottom: 14 })`

## 后续规划
- 偏好/数据库持久化（`preferences` / `@ohos.data.rdb`）
- 网络接口与数据同步协议
- 主题与暗色模式适配
- 底部导航封装为复用组件，统一管理激活态与路由