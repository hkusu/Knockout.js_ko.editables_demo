$ ->

  HogeViewModel = (name, age) ->

    # トランザクション開始用の内部関数
    begin_edit = ->
      self.name.beginEdit()
      self.age.beginEdit()
      return

    # コミット用の内部関数
    commit = ->
      self.name.commit()
      self.age.commit()
      return

    # ロールバック用の内部関数
    rollback = ->
      self.name.rollback()
      self.age.rollback()
      return

    # ViewModel のオブジェクト本体
    self =
      name: ko.observable(name) # 変数「name」を監視対象へ
      age: ko.observable(age)   # 変数「age」を監視対象へ
      cancel: -> # 「元に戻す」ボタンが押下された際のアクション
        rollback()   # ロールバック
        begin_edit() # 再度トランザクションを開始
        return
      save: ->   # 「保存する」ボタンが押下された際のアクション
        commit()     # コミット
        begin_edit() # 再度トランザクションを開始
        return

    # トランザクションの対象へ
    ko.editable(self)
    # 初期状態でトランザクション開始状態へ
    begin_edit()

    # リターン値としてオブジェクトを返す
    return self

  # View へ ViewModel をバインド
  if $("#main")[0]
    ko.applyBindings HogeViewModel("山田", 32), $("#main")[0]

  return
