#encoding: utf-8

class String
  @@alphabet = "абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"

  def cyrillic?
    arr = self.split ""
    arr.each do |s|
      return false unless @@alphabet.index(s)
    end
    return true
  end


  def trans
    chars = {
      'а' => 'a',
      'б' => 'b',
      'в' => 'v',
      'г' => 'g',
      'д' => 'd',
      'е' => 'e',
      'ё' => 'e',
      'ж' => 'g',
      'з' => 'z',
      'и' => 'i',
      'й' => 'i',
      'к' => 'k',
      'л' => 'l',
      'м' => 'm',
      'н' => 'n',
      'о' => 'o',
      'п' => 'p',
      'р' => 'r',
      'с' => 's',
      'т' => 't',
      'у' => 'u',
      'ф' => 'f',
      'х' => 'h',
      'ц' => 'c',
      'ч' => 'ch',
      'ш' => 'sh',
      'щ' => 'sh',
      'ъ' => '',
      'ы' => 'yi',
      'ь' => '',
      'э' => 'e',
      'ю' => 'ju',
      'я' => 'ja'
    }

    converted_string = ''

    self.downcase.split('').each do |char|
      converted_string += chars[char].nil? ? char : chars[char]
    end

    converted_string
  end

end