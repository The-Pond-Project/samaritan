#  Initialize the default local for Money
Money.locale_backend = :i18n
Money.rounding_mode = BigDecimal::ROUND_HALF_EVEN
I18n.locale = :en