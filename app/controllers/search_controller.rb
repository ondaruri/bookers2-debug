class SearchController < ApplicationController
  def search
    @model = params["search"]["model"] #選択したmodelを@modelに代入
    @value = params["search"]["value"] #検索にかけた文字列(ここではvalue)を@valueに代入
    @how = params["search"]["how"] #選択した検索方法howを@howに代入
    @datas = search_for(@how,@model,@value) #search_forの引数にインスタンス変数を定義
  end                                      #@datasに最終的な検索結果が入ります

  private

  def match(model, value)
    if model == 'user'
      User.where(name:value)
    elsif model == 'book'
      Book.where(title:value)
    end
  end

  def forward(model, value)
    if model == 'User'
      User.where("name LIKE?", "#{value}%")
    elsif model == 'book'
      Book.werer("title LIKE?", "#{value}%")
    end
  end

  def backward(model, value)
    if model == 'user'
      User.where("name LIKE?", "%#{value}")
    elsif model == 'book'
      Book.where("title LIKE?", "%#{value}")
    end
  end

  def partial(model,value)
    if model == 'user'
      User.where("name LIKE?", "%#{value}%")
    elsif model == 'book'
      Book.where("title LIKE?", "%#{value}%")
    end
  end

  def search_for(how,model,value) #searchアクションで定義した情報が引数に入っている
    case how
    when 'match'
      match(model, value) #検索方法の引数に(model, value)を定義している
    when 'forward'        #例えばhowがmatchの場合は def match の処理に進みます
      forward(model, value)
    when 'backward'
      backward(model, value)
    when 'partial'
      partial(model, value)
    end
  end
end
