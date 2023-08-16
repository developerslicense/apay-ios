//
// Created by Mikhail Belikov on 16.08.2023.
//

import Foundation

let ARG_ERROR_CODE = "errorCode"
let ARG_ACTION = "action"
let ARG_CARD_ID = "cardId"
let ARG_CARD_PAN = "cardPan"
let ARG_CARD_EXPIRE = "cardExpire"

let ROUTES_HOME = "home_page"
let ROUTES_SUCCESS = "success"
let ROUTES_REPEAT = "repeat"
let ROUTES_ERROR_FINAL = "error_final"
let ROUTES_ERROR_SOMETHING_WRONG = "error_something_wrong"


let TEMPLATE_ROUTES_ERROR = "error"
let ROUTES_ERROR = "error?$ARG_ERROR_CODE={$ARG_ERROR_CODE}"

let TEMPLATE_ROUTES_ERROR_WITH_INSTRUCTION = "error_with_instruction"
let ROUTES_ERROR_WITH_INSTRUCTION = "error_with_instruction?$ARG_ERROR_CODE={$ARG_ERROR_CODE}"

let TEMPLATE_DEEP_LINK_WEB_VIEW = "web_view_page"
let ROUTES_WEB_VIEW = "web_view_page?$ARG_ACTION={$ARG_ACTION}"