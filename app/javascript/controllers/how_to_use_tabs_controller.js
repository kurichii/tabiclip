import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="how-to-use-tabs"
export default class extends Controller {
  static targets = ["tab", "content"]

  tabClick(event){
    const tabs = this.tabTargets // タブ全体の要素
    const current = event.currentTarget // クリックしたタブの要素（現在地）
    const currentIndex = tabs.indexOf(current) // クリックしたタブのインデックス番号
    const contents = this.contentTargets // コンテンツ全体の要素

    tabs.forEach((tab, index) => { // 初期化
      if(current.classList.contains("not-active")){
        tab.classList.remove("is-active")
        tab.classList.add("not-active")
        contents[index].classList.add("hidden")
      }
    })

    if(current.classList.contains("not-active")){ // クリックしたメニューのclassをアクティブにする
      current.classList.remove("not-active")
      current.classList.add("is-active")
      contents[currentIndex].classList.remove("hidden") // クリックした要素のコンテンツを表示する
    }
  }
}
