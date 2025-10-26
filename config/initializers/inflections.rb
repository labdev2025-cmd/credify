# encoding: utf-8

ActiveSupport::Inflector.inflections do |inflect|
  inflect.clear

  # Plural
  inflect.plural(/$/, "s")
  inflect.plural(/s$/i, "s")
  inflect.plural(/^(país)$/i, '\1es')
  inflect.plural(/al$/i, "ais")
  inflect.plural(/el$/i, "éis")
  inflect.plural(/ol$/i, "óis")
  inflect.plural(/ul$/i, "uis")
  inflect.plural(/([^aeiou])il$/i, '\1is')
  inflect.plural(/m$/i, "ns")
  inflect.plural(/^(japon|escoc|ingl|dinamarqu|fregu|portugu)ês$/i, '\1eses')
  inflect.plural(/(ás)$/i, "ases")
  inflect.plural(/ão$/i, "ões")
  inflect.plural(/^(irm|m)ão$/i, '\1ãos')
  inflect.plural(/^(alem|c|p)ão$/i, '\1ães')
  inflect.plural(/or$/i, "ores")

  # Sem acento
  inflect.plural(/ao$/i, "oes")
  inflect.plural(/^(irm|m)ao$/i, '\1aos')
  inflect.plural(/^(alem|c|p)ao$/i, '\1aes')

  # Singular
  inflect.singular(/([^ê])s$/i, '\1')
  inflect.singular(/([rz])es$/i, '\1')
  inflect.singular(/ais$/i, "al")
  inflect.singular(/éis$/i, "el")
  inflect.singular(/óis$/i, "ol")
  inflect.singular(/uis$/i, "ul")
  inflect.singular(/is$/i, "il")
  inflect.singular(/ns$/i, "m")
  inflect.singular(/ões$/i, "ão")
  inflect.singular(/ãos$/i, "ão")
  inflect.singular(/ães$/i, "ão")
  inflect.singular(/oes$/i, "ao")
  inflect.singular(/(japon|escoc|ingl|dinamarqu|fregu|portugu)eses$/i, '\1ês')
  inflect.singular(/ases$/i, "ás")

  # Incontáveis (não mudam no plural)
  inflect.uncountable %w[
    tórax tênis ônibus lápis fênix óculos vírus status atlas
  ]

  # Irregulares
  inflect.irregular "país", "países"
  inflect.irregular "cão", "cães"
  inflect.irregular "pão", "pães"
  inflect.irregular "mão", "mãos"
  inflect.irregular "alemão", "alemães"
  inflect.irregular "cidadão", "cidadãos"
  inflect.irregular "homem", "homens"
  inflect.irregular "mulher", "mulheres"
  inflect.irregular "status", "status"
  inflect.irregular "mal", "males"
end
