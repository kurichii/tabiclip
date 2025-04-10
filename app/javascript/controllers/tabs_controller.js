import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
  static values = { spots: Array }
  static targets = ["tab", "content"]

  tabClick(event){
    // GoogleMapにspot情報を渡す
    this.spotsValue = JSON.parse(event.target.getAttribute("data-tabs-spots-value"));
    window.spots = this.spotsValue;
    initMap();

    const tabs = this.tabTargets // タブ全体の要素
    const current = event.currentTarget // クリックしたタブの要素（現在地）
    const currentIndex = tabs.indexOf(current) // クリックしたタブのインデックス番号
    const contents = this.contentTargets // コンテンツ全体の要素

    // 全てのタブを"not-active"にする
    tabs.forEach(tab => {
      tab.classList.remove("is-active");
      tab.classList.add("not-active");
    });

    // クリックしたタブに"is-active"を付与
    current.classList.add("is-active");
    current.classList.remove("not-active");

    // 全ての日程のスケジュール一覧を非表示にする
    contents.forEach(content => content.style.display = "none");

    // クリックされたタブと同じ日付のスケジュール一覧を表示する
    contents[currentIndex].style.display = "block";
  }
}
