# -*- coding: utf-8 -*-

class Integer
  def to_kansuji(opts = {})
    tbl     = build_number_table(opts)
    sign    = self >= 0 ? '' : '−'
    kansuji = opts[:place] == true ?
              to_kansuji_with_place(tbl, opts) :
              to_kansuji_without_place(tbl)
    sign << kansuji
  end

  private

  def build_number_table(opts)
    base_tbl = {
      :trad => {
          :new => %w(〇 壱 弐 参 四 伍 六 七 八 九),
          :old => %w(零 壹 貳 参 肆 伍 陸 漆 捌 玖),
      },
      :basic => %w(〇 一 二 三 四 五 六 七 八 九),
    }

    tbl = base_tbl[:basic]
    if opts[:trad] == :new
      tbl = base_tbl[:trad][:new]
    elsif opts[:trad] == :old
      tbl = base_tbl[:trad][:old]
    end

    tbl[0] = '〇' if opts[:zero] == :new
    tbl[0] = '零' if opts[:zero] == :old
    tbl
  end

  def to_kansuji_without_place(tbl)
    self.abs.to_s.split(//).map {|n| tbl[n.to_i]}.join
  end

  def is_trad(opts)
    opts[:trad] == :new || opts[:trad] == :old
  end

  def chunk_from_tail(str)
    str.reverse.gsub(/(.{4})/, '\1,').reverse.split(',').delete_if{|x| x.length <= 0}.map{|str| str.split(//)}
  end

  def build_place_tbl(opts)
    [
      '',
      is_trad(opts) ? '萬' : '万',
      '億',
      '兆',
      '京',
      '垓',
      '𥝱',
      '穣',
      '溝',
      '澗',
      '正',
      '載',
      '極',
      '恒河沙',
      '阿僧祇',
      '那由他',
      '不可思議',
      '無量大数'
    ]
  end

  def build_subplace_tbl(opts)
    if is_trad(opts)
      {
        4 => ['阡', '百', '拾', ''],
        3 => ['百', '拾', ''],
        2 => ['拾', ''],
        1 => [''],
      }
    else
      {
        4 => ['千', '百', '十', ''],
        3 => ['百', '十', ''],
        2 => ['十', ''],
        1 => [''],
      }
    end
  end

  def to_kansuji_with_place(tbl, opts)
    kansuji = to_kansuji_without_place(tbl)
    return kansuji if self.abs <= 9

    place_units   = chunk_from_tail(kansuji)
    place_tbl     = build_place_tbl(opts)
    subplace_tbls = build_subplace_tbl(opts)

    place_units.reverse.map do |unit|
      unit = unit.zip(subplace_tbls[unit.length]).delete_if do |pair|
        /\A[〇零]\z/ =~ pair[0]
      end

      place = place_tbl.shift
      unit.length > 0 ? (unit << place) : unit 
    end.reverse.join.gsub(/[壱一]([百十拾])/, '\1')
  end
end
