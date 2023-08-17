//
// Created by Mikhail Belikov on 16.08.2023.
//

import Foundation

internal let ARG_ERROR_CODE = "errorCode"
internal let ARG_ACTION = "action"
internal let ARG_CARD_ID = "cardId"
internal let ARG_CARD_PAN = "cardPan"
internal let ARG_CARD_EXPIRE = "cardExpire"

internal let ROUTES_HOME = "home_page"
internal let ROUTES_SUCCESS = "success"
internal let ROUTES_REPEAT = "repeat"
internal let ROUTES_ERROR_FINAL = "error_final"
internal let ROUTES_ERROR_SOMETHING_WRONG = "error_something_wrong"


internal let TEMPLATE_ROUTES_ERROR = "error"
internal let ROUTES_ERROR = "error?$ARG_ERROR_CODE={$ARG_ERROR_CODE}"

internal let TEMPLATE_ROUTES_ERROR_WITH_INSTRUCTION = "error_with_instruction"
internal let ROUTES_ERROR_WITH_INSTRUCTION = "error_with_instruction?$ARG_ERROR_CODE={$ARG_ERROR_CODE}"

internal let TEMPLATE_DEEP_LINK_WEB_VIEW = "web_view_page"
internal let ROUTES_WEB_VIEW = "web_view_page?$ARG_ACTION={$ARG_ACTION}"