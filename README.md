## Техническая документация для интеграции sdk AirbaPay в мобильные приложения

------------------------------------------------------------------------------------------------------------------------
## V2
------------------------------------------------------------------------------------------------------------------------

## 1 Подключение sdk

## 2 Flutter - дополнительные шаги интеграции

## 3 Подключение нативного ApplePay

## 4 API создания платежа

## 5 API формы стандартного флоу

## 6 API ApplePay

## 7 API сохраненных карт




## 1 Подключение sdk  

1) SPM -> GitHub - ```developerslicense/apay-ios```

2) Нужно добавить конфиги в ```info.plist```

   ```
   KEY -> Privacy - Face ID Usage Description
   
   TYPE -> String
   
   VALUE -> “Запрос доступа к сохраненным картам”
   ```

   ```
   KEY -> Privacy - Privacy - Camera Usage Description
   
   TYPE -> String
   
   VALUE -> “Предоставьте разрешение для использования сканнера банковских карт”
   ```

3) Нужно добавить ```import AirbaPay``` в файле ```App``` и в месте использования в приложении.
   В ```App``` нужно выполнить ```регистрацию шрифтов``` при инициализации.

```
@main
struct TestApp: App {
    init() {
        AirbaPayFonts.registerCustomFonts()
        ~~~
    }
```

Для инициализации sdk нужно выполнить ```AirbaPaySdk.initSdk()```. Функция возвращает экземпляр класса```AirbaPaySdk```.

| Параметр                  | Тип                                               | Обязательный | Описание                                                                                                                                              |
|---------------------------|---------------------------------------------------|--------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| isProd                    | Bool                                              | да           | Продовская или тестовая среда airbapay                                                                                                                |
| lang                      | AirbaPaySdk.Lang                                  | да           | Код языка для UI                                                                                                                                      |
| phone                     | String                                            | да           | Телефон пользователя                                                                                                                                  |
| userEmail                 | String                                            | нет          | Емейл пользователя, куда будет отправлена квитанция. В случае отсутствия емейла                                                                       |
| colorBrandMain            | Color                                             | нет          | Брендовый цвет кнопок, переключателей и текста                                                                                                        |
| colorBrandInversion       | Color                                             | нет          | Цвет текста у кнопок с брендовым цветом                                                                                                               |
| enabledLogsForProd        | Bool                                              | нет          | Флаг для включения логов                                                                                                                              |
| needDisableScreenShot     | Bool                                              | нет          | Флаг включения/отключения защиты от скриншота страниц. По дефолту выключен                                                                            |
| actionOnCloseProcessing   | @escaping (Bool?, UINavigationController) -> Void | да           | Лямбда, вызываемая при клике на кнопку "Вернуться в магазин" и при отмене процесса. Разработчику в ней нужно прописать код для возврата в приложение. |
| openCustomPageSuccess     | (() -> Void)?                                     | нет          | Лямбда кастомной страницы успеха                                                                                                                      |
| openCustomPageFinalError  | (() -> Void)?                                     | нет          | Лямбда кастомной страницы финальной ошибки                                                                                                            |


Пример:

```    
       let airbaPaySdk = AirbaPaySdk.initSdk(
            isProd: false,
            lang: AirbaPaySdk.Lang.RU(),
            phone: PHONE,
            userEmail: "test@test.com",
            colorBrandMain: Color.red,
            actionOnCloseProcessing: { isSuccess, navigation in
               navigation.present(~)   
            }
       )


 ```

## 2 Flutter - дополнительные шаги интеграции

1) В dart добавьте:

   ```
     final MethodChannel channel = MethodChannel("com.example.testFlutter/AirbaPayChannel");
   
     Future<void> callNativeMethod() async {
       try {
         await channel.invokeMethod('pay');
       } catch (e) {
         print('Error calling native method: $e');
       }
     }
   ```

   И нужно вызвать ```callNativeMethod``` для перехода на страницы сдк.

2) Создайте файл ```AirbaPayHandler```

   ```
   
   import Foundation
   import Flutter
   import SwiftUI
   
   func handleAirbaPayChannel(
     _ app: AppDelegate,
     _ call: FlutterMethodCall,
     _ result: OneShotFlutterResult
   ) {
   
     if call.method == "pay" {
       let airbaPaySdk = AirbaPaySdk.initSdk(
         ~
         actionOnCloseProcessing: { result, uiNavigationController in
            // Здесь нужно использовать OneShotFlutterResult для возврата результата
            // и закрытия сдк через uiNavigationController.dismiss(animated: false) или другие способы
         )
       )
       airbaPaySdk.standardFlow(
            isApplePayNative: true,
            applePayMerchantId: "merchant.~",
            shopName: "Shop Name"
       )
    
     } else {
       result.submit(FlutterMethodNotImplemented)
     }
   }
   
   
   class OneShotFlutterResult {
     private var result: FlutterResult?
     
     init(_ result: @escaping FlutterResult) {
       self.result = result
     }
     
     func submit(_ data: Any) {
       if (result != nil) {
         result!(data)
         result = nil
       }
     }
   }
   
   ```

3) Добавьте в ```AppDelegate```

   ```
   let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
   
   let airbaPayChannel = FlutterMethodChannel(
        name: "com.example.testFlutter/AirbaPayChannel",
        binaryMessenger: controller.binaryMessenger
   )
         
   airbaPayChannel.setMethodCallHandler({ call, result -> Void in
        handleAirbaPayChannel(self, call, OneShotFlutterResult(result))
   })
   ```

## 3 Подключение нативного ApplePay

1) Добавить параметры в ```standardFlow```
   ```isApplePayNative: true```
   ```applePayMerchantId: "merchant.~"```
   ```shopName: "Shop Name" ```

2) Перейти в консоль ApplePay https://developer.apple.com/account/resources/identifiers/list

3) Добавьте в Certificates

   1й Type -> Apple Pay Payment Processing Certificate Name ->  merchant...pf   
   2й Type -> Apple Pay Merchant Identity Certificate Name ->  merchant...pf   
   3й Type -> Apple Pay Payment Processing Certificate Name ->  merchant...spf   
   4й Type -> Apple Pay Merchant Identity Certificate Name ->  merchant...spf

4) Перейти во внутрь идентификатора приложения. Поставьте галочку в ```Apple Pay Payment Processing``` и кликните edit

5) Выберите
   - Apple Pay Prod Service merchant.~.pf
   - Apple Pay Test Service merchant.~.spf
   
   и нажмите continue

6) Нажмите Save

7) Зайдите в XCode в Targets -> Signing & Capabilities добавьте Apple Pay айди мерчантов поставьте галочки

## 4 API создания платежа

Запрос на авторизацию в системе AirbaPay через передачу логина, пароля и айди терминала. Возвращает токен.
```authPassword()```

| Параметр   | Тип                        | Обязательный | Описание                                                                                                              |
|------------|----------------------------|--------------|-----------------------------------------------------------------------------------------------------------------------|
| terminalId | String                     | да           | ID терминала под которым создаётся платеж                                                                             |
| shopId     | String                     | да           | ID магазина в системе AirbaPay                                                                                        |
| password   | String                     | да           | Пароль в системе AirbaPay                                                                                             |
| paymentId  | String?                    | нет          | ID платежа. В абсолютном большинстве случаев в этом запросе будет null. Нужен для обновления токена с новым paymentId |
| onSuccess  | @escaping (String) -> Void | да           | Лямбда на успех. Возвращает токен                                                                                     |
| onError    | @escaping  () -> Void      | да           | Лямбда на ошибку                                                                                                      |


```
airbaPaySdk.authPassword(
      terminalId: "123qdfssdf",
      shopId: "test", 
      password: "test123!"
      onSuccess: { token in ~  },
      onError: { ~ }    
)
        
```

Запрос на авторизацию в системе AirbaPay через передачу JWT.
```authJwt()```

| Параметр    | Тип                  | Обязательный | Описание           |
|-------------|----------------------|--------------|--------------------|
| jwt         | String               | да           | JWT токен          |
| onSuccess   | @escaping () -> Void | да           | Лямбда на успех.   |
| onError     | @escaping () -> Void | да           | Лямбда на ошибку   |


```
airbaPaySdk.authJwt(
        onSuccess: { ~  },
        onError: { ~ },
        jwt: "~"
)
        
```

Запрос на инициализацию платежа в системе AirbaPay.
Возвращает ```paymentId``` и вторым параметром обновленный токен.
```createPayment()```

| Параметр               | Тип                             | Обязательный    | Описание                                                                                                              |
|------------------------|---------------------------------|-----------------|-----------------------------------------------------------------------------------------------------------------------|
| authToken              | String                          | да              | Токен, полученный из auth или другой реализацией получения токена                                                     |
| failureCallback        | String                          | да              | URL вебхука при ошибке                                                                                                |
| successCallback        | String                          | да              | URL вебхука при успехе                                                                                                |
| purchaseAmount         | Double                          | да              | Сумма платежа                                                                                                         |
| accountId              | String                          | да              | ID аккаунта пользователя                                                                                              |
| invoiceId              | String                          | да              | ID платежа в системе магазина                                                                                         |
| orderNumber            | String                          | да              | Номер заказа в системе магазина                                                                                       |
| onSuccess              | (String) -> Void                | да              | Лямбда на успех. Возвращает paymentId                                                                                 |
| onError                | () -> Void                      | да              | Лямбда на ошибку                                                                                                      |
| renderApplePay         | Bool?                           | нет             | Флаг настройки показа функционала ApplePay в стандартном флоу. NULL - параметры с сервера                             |
| renderSavedCards       | Bool?                           | нет             | Флаг настройки показа функционала сохраненных карт в стандартном флоу. NULL - параметры с сервера                     |
| renderSecurityBiometry | Bool?                           | нет             | Флаг глобальной настройки в сдк для биометрии при оплате сохраненной картой или ApplePay. NULL - параметры с сервера  |
| renderSecurityCvv      | Bool?                           | нет             | Флаг глобальной настройки в сдк для показа боттомщита с CVV при оплате сохраненной картой. NULL - параметры с сервера |
| autoCharge             | Int                             | нет             | Автоматическое подтверждение при 2х-стадийном режиме 0 - нет, 1 - да                                                  |
| goods                  | [AirbaPaySdk.Goods]             | нет             | Список продуктов для оплаты. Если есть необходимость передачи списка товаров в систему                                |
| settlementPayments     | [AirbaPaySdk.SettlementPayment] | нет             | Распределение платежа по компаниям. В случае одной компании, может быть null                                          |


```
airbaPaySdk.createPayment(
                authToken: token,
                failureCallback: "https://site.kz/failure-clb",
                successCallback: "https://site.kz/success-clb",
                purchaseAmount: 1500.45,
                accountId: "77061111112",
                invoiceId: "1111111111",
                orderNumber: "ab1111111111"
                onSuccess: { paymentId -> ~ },
                onError: { ~ }
            )            
```


## 5 API формы стандартного флоу

Предварительно выполнить ```airbaPaySdk.authPassword()``` вместе с ```airbaPaySdk.createPayment()```
Или выполнить только ```airbaPaySdk.authJwt()```

Открытие стандартной формы AirbaPay выполняется через ```airbaPaySdk.standardFlow()```.

| Параметр            | Тип     | Обязательный | Описание                                                               |
|---------------------|---------|--------------|------------------------------------------------------------------------|
| isApplePayNative    | Bool    | да           | Флаг, определяющий показ нативной кнопки ApplePay вместо вебвьюшки     |
| applePayMerchantId  | String? | да           | ID мерчанта ApplePay. Нужен для нативной формы. В случае вебверсии NIL |
| shopName            | String  | нет          | Название магазина, передающееся в боттомщит ApplePay                   |

```
    airbaPaySdk.standardFlow(
        isApplePayNative: true,
        applePayMerchantId: "merchant.~",
        shopName: "Shop Name"
    )
    
    или для вебверсии ApplePay
    
    airbaPaySdk.standardFlow(
        isApplePayNative: false,
        applePayMerchantId: nil
    )
```

## 6 API ApplePay

Для работы с ApplePay за пределами стандартного флоу:

1) Полностью реализовать на стороне приложения механизм вызова ApplePay боттомщита
   и получения ApplePay токена.

2) Выполнить пункт "3 Подключение нативного ApplePay"

3) Предварительно выполнить ```airbaPaySdk.authPassword()``` вместе с ```airbaPaySdk.createPayment()```
   Или выполнить только ```airbaPaySdk.authJwt()```

4) Вызвать после получения токена ApplePay функцию  ```processExternalApplePay()```

   | Параметр       | Тип      | Обязательный | Описание       |
   |----------------|----------|--------------|----------------|
   | applePayToken  | String   | да           | Токен ApplePay |


   ``` 
    airbaPaySdk.processExternalApplePay(applePayToken: applePayToken)
   ```


## 7 API сохраненных карт

Запрос списка сохраненных карт пользователя
```getCards()```
Предварительно выполнить ```airbaPaySdk.authPassword()``` или ```airbaPaySdk.authJwt()```

| Параметр  | Тип                            | Обязательный | Описание                                       |
|-----------|--------------------------------|--------------|------------------------------------------------|
| onSuccess | @escaping ([BankCard]) -> Void | да           | Замыкание на успех со списком сохраненных карт |
| onNoCards | @escaping () -> Void           | да           | Замыкание на отсутствие сохраненных карт       |

Запрос удаления сохраненной карты пользователя
```deleteCard()```
Предварительно выполнить ```airbaPaySdk.authPassword()``` или ```airbaPaySdk.authJwt()```

| Параметр  | Тип                  | Обязательный | Описание             |
|-----------|----------------------|--------------|----------------------|
| cardId    | String               | да           | ID сохраненной карты |
| onSuccess | @escaping () -> Void | да           | Замыкание на успех   |
| onError   | @escaping () -> Void | да           | Замыкание на ошибку  |

Запрос проведения оплаты по сохраненной карте пользователя
```paySavedCard()```
Предварительно выполнить ```airbaPaySdk.authPassword()``` или ```airbaPaySdk.authJwt()```

| Параметр   | Тип                      | Обязательный | Описание                                              |
|------------|--------------------------|--------------|-------------------------------------------------------|
| bankCard   | BankCard                 | да           | Экземпляр карты, получаемый из запроса ```getCards``` |
| isLoading  | @escaping (Bool) -> Void | да           | Замыкание для показа прогрессбара                     |
| onError    | @escaping () -> Void     | да           | Замыкание на ошибку                                   |


------------------------------------------------------------------------------------------------------------------------
## V1
------------------------------------------------------------------------------------------------------------------------

## 1 Подключение sdk

## 2 Вызов стартовой формы

## 3 Пример использования

## 4 Подключение нативного ApplePay

## 5 Подключение API внешнего взаимодействия с ApplePay (Нативный)

## 6 Подключение API внешнего взаимодействия с ApplePay (Вебвью)

## 7 Рекомендация в случае интеграции в flutter

## 1  Подключение sdk

1) SPM -> GitHub - ```developerslicense/apay-ios```

2) Нужно добавить конфиги в ```info.plist```

```
KEY -> Privacy - Face ID Usage Description

TYPE -> String

VALUE -> “Запрос доступа к сохраненным картам”
```

```
KEY -> Privacy - Privacy - Camera Usage Description

TYPE -> String

VALUE -> “Предоставьте разрешение для использования сканнера банковских карт”
```

3) Нужно добавить ```import AirbaPay``` в файле ```App``` и в месте использования в приложении.
   В ```App``` нужно выполнить ```регистрацию шрифтов``` при инициализации.

```
@main
struct TestApp: App {
    init() {
        AirbaPayFonts.registerCustomFonts()
        ~~~
    }
```

Для инициализации sdk нужно выполнить ```AirbaPaySdk.initSdk()``` перед
вызовом ```AirbaPaySdk.startAirbaPay() ```.

| Параметр              | Тип                                  | Обязательный | Описание                                                                        |
|-----------------------|--------------------------------------|--------------|---------------------------------------------------------------------------------|
| shopId                | String                               | да           | ID магазина в системе AirbaPay                                                  |
| password              | String                               | да           | Пароль в системе AirbaPay                                                       |
| terminalId            | String                               | да           | ID терминала под которым создали платеж                                         |
| accountId             | String                               | да           | ID аккаунта пользователя                                                        |
| lang                  | AirbaPaySdk.Lang                     | да           | Код языка для UI                                                                |
| isProd                | Bool                                 | да           | Продовская или тестовая среда airbapay                                          |
| phone                 | String                               | да           | Телефон пользователя                                                            |
| failureCallback       | String                               | да           | URL вебхука при ошибке                                                          |
| successCallback       | String                               | да           | URL вебхука при успехе                                                          |
| userEmail             | String                               | да           | Емейл пользователя, куда будет отправлена квитанция. В случае отсутствия емейла |
| colorBrandMain        | Color                                | нет          | Брендовый цвет кнопок, переключателей и текста                                  |
| colorBrandInversion   | Color                                | нет          | Цвет текста у кнопок с брендовым цветом                                         |
| autoCharge            | Int                                  | нет          | Автоматическое подтверждение при 2х-стадийном режиме 0 - нет, 1 - да            |
| enabledLogsForProd    | Bool                                 | нет          | Флаг для включения логов                                                        |
| purchaseAmount        | Double                               | да           | Сумма платежа                                                                   |
| invoiceId             | String                               | да           | ID платежа в системе магазина                                                   | 
| orderNumber           | String                               | да           | Номер заказа в системе магазина                                                 |
| goods                 | Array<AirbaPaySdk.Goods>             | да           | Список продуктов для оплаты                                                     |
| settlementPayments    | Array<AirbaPaySdk.SettlementPayment> | нет          | Распределение платежа по компаниям. В случае одной компании, может быть nil     |
| shopName              | String                               | нет          | Название магазина для нативного ApplePay                                        |
| isApplePayNative      | Bool                                 | нет          | Флаг, определяющий показ нативной кнопки ApplePay вместо вебвьюшки              |
| applePayMerchantId    | String                               | нет          | Айдишка мерчанта, прописанная в консоли ApplePay                                |
| needDisableScreenShot | Bool                                 | нет          | Флаг включения/отключения защиты от скриншота страниц. По дефолту выключен      |

Пример:

```
      let goods = [
           AirbaPaySdk.Goods(
               model: "Чай Tess Banana Split черный 20 пирамидок",
               brand: "Tess",
               category: "Черный чай",
               quantity: 1,
               price: 1000
           )
       ]

       let settlementPayment = [
           AirbaPaySdk.SettlementPayment(
               amount: 1000,
               companyId: "test_id"
           )
       ]
       
       AirbaPaySdk.initSdk(
            isProd: false,
            lang: AirbaPaySdk.Lang.RU(),
            accountId: ACCOUNT_ID_TEST,
            phone: PHONE,
            userEmail: "test@test.com",
            shopId: "test",
            password: "123456!",
            terminalId: "64216e7ccc4a48db060dd6891",
            failureCallback: "https://site.kz/failure-clb",
            successCallback: "https://site.kz/success-clb",
            colorBrandMain: Color.red,
            autoCharge: autoCharge,
            purchaseAmount: 1500.0,
            invoiceId: String(someInvoiceId),
            orderNumber: String(someOrderNumber),
            goods: goods,
            settlementPayments: settlementPayment,
            isApplePayNative: true,
            shopName: "Shop Name",
            applePayMerchantId: "merchant.~"
      )


 ```

## 2 Вызов стартовой формы

```
@ObservedObject var navigateCoordinator = AirbaPayCoordinator(
            actionOnOpenProcessing: { ~ },
            actionOnCloseProcessing: { result in  ~ },
            customSuccessPageView: AnyView(~~~)
    )
```

Открытие формы AirbaPay выполняется через AirbaPaySdk.startAirbaPay().

| Параметр                   | Тип            | Обязательный | Описание                                                           |
|----------------------------|----------------|--------------|--------------------------------------------------------------------|
| isCustomSuccessPageView    | Bool           | нет          | Флаг переключения на кастомную вьюшку успешного кейса              |
| isCustomFinalErrorPageView | Bool           | нет          | Флаг переключения на кастомную вьюшку финального неуспешного кейса |
| actionOnOpenProcessing     | () -> Void     | нет          | Действие на открытие процессинга                                   |
| actionOnCloseProcessing    | (Bool) -> Void | нет          | Действие на закрытие процессинга с возвратом результата            | 

```AirbaPayView```

| Параметр            | Тип                                 | Обязательный | Описание                                      |
|---------------------|-------------------------------------|--------------|-----------------------------------------------|
| navigateCoordinator | @ObservedObject AirbaPayCoordinator | да           | Координатор навигации                         |
| contentView         | AnyView?                            | да           | Контент страницы, на которой будет вызван sdk |

# SwiftUi:

Контент страницы приложения обернуть в ```AirbaPayView```

```
var body: some View {
           AirbaPayView(
                navigateCoordinator: navigateCoordinator,
                contentView: contentView
            )
}
 ```

# UIKit:

Открыть новую страницу с содержимым swiftUi.

Ниже описан кратко вариант интеграции. Более подробно описано в статье
https://sarunw.com/posts/swiftui-view-as-uiview-in-storyboard/

- Добавить ```Container View``` и удалить привязанный к нему дефолтный ```ViewController```
- Добавить ```UIHostingController``` и привязать ```Container View``` к нему через ```Embed```
- Связать это с ```ViewController``` кодом, указанным ниже

```
@IBSegueAction func initPage(_ coder: NSCoder) -> UIViewController? {
        
        AirbaPaySdk.initSdk(~)

        return UIHostingController(coder: coder, rootView: SwiftUIView(
            actionOnClick: {
                DispatchQueue.main.async {
                    let hostingController = UIHostingController(
                        rootView: AirbaPayView(
                            navigateCoordinator: self.navigateCoordinator,
                            contentView: {}
                        ).onAppear {
                            self.navigateCoordinator.startProcessing()
                        }
                    )
                    
                    self.navigationController?.pushViewController(hostingController, animated: true)
                }
            },
            navigateCoordinator: navigateCoordinator
        ))
}

struct SwiftUIView: View {
    var actionOnClick: () -> Void
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator

    var body: some View {
        Button(
            action: actionOnClick,
            label: { Text("Продолжить") }
        )  
    }
}
```

## 3 Пример использования

В случае наличия на странице системных элементов управления (к примеру, кнопки назад),
обязательно нужно скрыть их (в случае навигации в swiftUi через  ```.navigationBarBackButtonHidden(true) ```)

```
struct TestCustomSuccessPage: View {

    var body: some View {
        Button(action: {}, label: { Text("TestSuccessPage") })
    }
}



struct TestPage: View {
    var back: () -> Void
    var phone: String = ""

    @ObservedObject var navigateCoordinator = AirbaPayCoordinator(
            customSuccessPageView: AnyView(TestCustomSuccessPage())
    )

    var body: some View {
            AirbaPayView(
                    navigateCoordinator: navigateCoordinator,
                    contentView: {

                        VStack {
                                Button(
                                        action: {

                                            AirbaPaySdk.initSdk(~~~)
                                            navigateCoordinator.startProcessing()

                                        },

                                        label: {
                                            Text("переход на эквайринг")
                                        }
                                )
                                Spacer()
                            }
                    }
            )
    }
}
```

## 4 Подключение нативного ApplePay

1) Добавить параметры в initSdk
   ```isApplePayNative: true```
   ```applePayMerchantId: "merchant.~"```

2) Перейти в консоль ApplePay https://developer.apple.com/account/resources/identifiers/list

3) Добавьте в Certificates

   1й Type -> Apple Pay Payment Processing Certificate Name ->  merchant...pf   
   2й Type -> Apple Pay Merchant Identity Certificate Name ->  merchant...pf   
   3й Type -> Apple Pay Payment Processing Certificate Name ->  merchant...spf   
   4й Type -> Apple Pay Merchant Identity Certificate Name ->  merchant...spf

4) Перейти во внутрь идентификатора приложения. Поставьте галочку в ```Apple Pay Payment Processing``` и кликните edit

5) Выберите
   ~ Apple Pay Prod Service merchant.~.pf
   ~ Apple Pay Test Service merchant.~.spf
   и нажмите continue

6) Нажмите Save

7) Зайдите в XCode в Targets -> Signing & Capabilities добавьте Apple Pay айди мерчантов поставьте галочки

## 5 Подключение API внешнего взаимодействия с ApplePay (Нативный)

```buyBtnTapped```

| Параметр                        | Тип           | Обязательный | Описание                                  |
|---------------------------------|---------------|--------------|-------------------------------------------|
| redirectFromStoryboardToSwiftUi | (() -> Void)? | нет          | Замыкание перехода в сдк для UIKit        |
| backToStoryboard                | (() -> Void)? | нет          | Замыкание возврата в приложение для UIKit |

```ApplePayManager```

| Параметр            | Тип                                 | Обязательный | Описание              |
|---------------------|-------------------------------------|--------------|-----------------------|
| navigateCoordinator | @ObservedObject AirbaPayCoordinator | да           | Координатор навигации |

# SwiftUi:

1) Добавить, как указано в примере:

``` 
struct TestPage: View {
    
    @ObservedObject var navigateCoordinator = AirbaPayCoordinator(~)
    
     var body: some View {
        let applePay = ApplePayManager(navigateCoordinator: navigateCoordinator)

        AirbaPayView(
                navigateCoordinator: navigateCoordinator,
                contentView: {
                  // контент страницы приложения 
                  ~~~
                  
                  // кнопка продолжения 
                  Button(
                     action: {
                        ~~~
                        
                        AirbaPaySdk.initSdk(
                           ~
                           isApplePayNative: true,
                           shopName: ~,
                           applePayMerchantId:  "merchant.~"
                       )
                       
                       applePay.buyBtnTapped()
                       
                     }
                  )
                }
        )
     }           
```

# UIKit:

## Внимание! Для UIKit недоступны кастомные страницы завершения

1. Добавить импорты во  ```ViewController```

   ```
   import SwiftUI
   import AirbaPay
   ```

2. Добавить

   ```
      @ObservedObject var navigateCoordinator = AirbaPayCoordinator()
   ```

3. Дальше надо выполнить ряд действий для подключения вьюшки в UIKit.
   Ниже описан кратко вариант интеграции. Более подробно описано в статье
   https://sarunw.com/posts/swiftui-view-as-uiview-in-storyboard/

- Добавить ```Container View``` и удалить привязанный к нему дефолтный ```ViewController```
- Добавить ```UIHostingController``` и привязать ```Container View``` к нему через ```Embed```
- Связать это с ```ViewController``` кодом, указанным ниже

```
@IBSegueAction func addApplePay(_ coder: NSCoder) -> UIViewController? {
        
        AirbaPaySdk.initSdk(~)
        let applePay = ApplePayManager(navigateCoordinator: navigateCoordinator)

        return UIHostingController(coder: coder, rootView: SwiftUIView(
            actionOnClick: {
                let hostingController = UIHostingController(
                    rootView: AirbaPayNextStepApplePayView(navigateCoordinator: self.navigateCoordinator)
                )
                
                self.navigationController?.pushViewController(hostingController, animated: true)
            },
            actionOnClose: {
                self.navigationController?.popViewController(animated: true)
            },
            navigateCoordinator: navigateCoordinator,
            applePay: applePay
        ))
}

struct SwiftUIView: View {
    var actionOnClick: () -> Void
    var actionOnClose: () -> Void
    @ObservedObject var navigateCoordinator: AirbaPayCoordinator
    let applePay: ApplePayManager
 
    var body: some View {
        Button(
            action: {
               applePay.buyBtnTapped(
                        redirectFromStoryboardToSwiftUi: actionOnClick,
                        backToStoryboard: actionOnClose
               )
            }
        )
    }
}
```

## 6 Подключение API внешнего взаимодействия с ApplePay (Вебвью)

Для работы с ApplePay потребуется вьюшка ```ApplePayWebViewExternal``` из ```AirbaPay```.
Визуально она не будет отображаться на экране, т.к. занимает всего 0.1. Вьюшку можно поместить вниз экрана.

| Параметр                        | Тип                                 | Обязательный | Описание                                       |
|---------------------------------|-------------------------------------|--------------|------------------------------------------------|
| redirectFromStoryboardToSwiftUi | (() -> Void)?                       | нет          | Замыкание перехода в сдк для UIKit             |
| backToStoryboard                | (() -> Void)?                       | нет          | Замыкание возврата в приложение для UIKit      |
| navigateCoordinator             | @ObservedObject AirbaPayCoordinator | да           | Координатор навигации                          |
| isLoading                       | @escaping (Bool) -> Void            | да           | Замыкание для показа лоадинга или плейсхолдера |
| applePayViewModel               | @ObservedObject ApplePayViewModel   | да           | ViewModel для работы с эппл пэй из AirbaPay    |

# SwiftUi:

1) Выполнить в ```onAppear``` ```AirbaPaySdk.initSdk(~)```

2) Добавить, как указано в примере:

``` 
struct TestPage: View {
    
    @ObservedObject var navigateCoordinator = AirbaPayCoordinator(~)
    @ObservedObject var applePayViewModel = ApplePayViewModel()
    
     var body: some View {

        AirbaPayView(
                navigateCoordinator: navigateCoordinator,
                contentView: {
                  // контент страницы приложения 
                  ~~~
                  
                  // кнопка продолжения 
                  Button(
                     action: {
                        ~~~
                        // Нужно показать прогрессбар, т.к. потребуется время для загрузки
                       
                        applePayViewModel.auth(
                               onError: {
                                 // Коллбэк для обработки ошибки и скрытия прогрессбара
                               },
                               onSuccess: {
                                  // Коллбэк для скрытия прогрессбара 
                               }
                           )
                       
                     }
                  )
                  
                   ApplePayWebViewExternal(
                       navigateCoordinator: navigateCoordinator,
                       applePayViewModel: applePayViewModel
                  )
                }
        )
     }           
```

# UIKit:

## Внимание! Для UIKit недоступны кастомные страницы завершения

1. Добавить импорты во  ```ViewController```

```
import SwiftUI
import AirbaPay
```

2. Добавить

```
   @ObservedObject var navigateCoordinator = AirbaPayCoordinator()
```

3. Дальше надо выполнить ряд действий для подключения вьюшки в UIKit.
   Ниже описан кратко вариант интеграции. Более подробно описано в статье
   https://sarunw.com/posts/swiftui-view-as-uiview-in-storyboard/

- Добавить ```Container View``` и удалить привязанный к нему дефолтный ```ViewController```
- Добавить ```UIHostingController``` и привязать ```Container View``` к нему через ```Embed```
- Связать это с ```ViewController``` кодом, указанным ниже

```
@IBSegueAction func addApplePay(_ coder: NSCoder) -> UIViewController? {
        
        AirbaPaySdk.initSdk(~)

        return UIHostingController(coder: coder, rootView: SwiftUIView(
            actionOnClick: {
                let hostingController = UIHostingController(
                    rootView: AirbaPayNextStepApplePayView(navigateCoordinator: self.navigateCoordinator)
                )
                
                self.navigationController?.pushViewController(hostingController, animated: true)
            },
            actionOnClose: {
                self.navigationController?.popViewController(animated: true)
            },
            navigateCoordinator: navigateCoordinator

        ))
}

struct SwiftUIView: View {
    var actionOnClick: () -> Void
    var actionOnClose: () -> Void
    @ObservedObject var navigateCoordinator = AirbaPayCoordinator()
    @ObservedObject var applePayViewModel = ApplePayViewModel()
    
    var body: some View {
        ZStack {
            Color.gray
            Color.white
            VStack {   
            
                // кнопка продолжения 
                Button(
                    action: {
                        applePayViewModel.auth(
                            onError: {
                                 // Коллбэк для обработки ошибки и скрытия прогрессбара
                            },
                            onSuccess: {
                                  // Коллбэк для скрытия прогрессбара 
                            }
                        )
                    }
                )
               
               ApplePayWebViewExternal(
                    redirectFromStoryboardToSwiftUi: actionOnClick,
                    backToStoryboard: actionOnClose,
                    navigateCoordinator: navigateCoordinator,
                    applePayViewModel: applePayViewModel
                )
            }
        }
    }
}
```

## 7 Рекомендация в случае интеграции в flutter

1) В dart добавьте:

```
  final MethodChannel channel = MethodChannel("com.example.testFlutter/AirbaPayChannel");

  Future<void> callNativeMethod() async {
    try {
      await channel.invokeMethod('pay');
    } catch (e) {
      print('Error calling native method: $e');
    }
  }
```

И нужно вызвать ```callNativeMethod``` для перехода на страницы сдк.

2) Создайте файл ```AirbaPayHandler```

```

import Foundation
import Flutter
import AirbaPay
import SwiftUI

func handleAirbaPayChannel(
  _ app: AppDelegate,
  _ call: FlutterMethodCall,
  _ result: OneShotFlutterResult
) {
  let controller : FlutterViewController = app.window?.rootViewController as! FlutterViewController

  if call.method == "pay" {
    let lang: AirbaPaySdk.Lang = AirbaPaySdk.Lang.RU()

    let someInvoiceId = ~
    let someOrderNumber = ~
      
      let goods = AirbaPaySdk.Goods(
        brand: "TechnoFit",
        category: "Services",
        model: "asdafasfd",
        quantity: 1,
        price: 5500
      )
      
    AirbaPaySdk.initSdk(
      isProd: false,
      lang: lang,
      accountId: "10000001",
      phone: "+77050000010",
      userEmail: "asdasd@sad.com",
      shopId: "test-baykanat",
      password:  "baykanat123!",
      terminalId:  "64216e7ccc4a48db060dd689", 
      failureCallback: "https://site.kz/failure-clb",
      successCallback: "https://site.kz/success-clb",
      autoCharge: 0,
      enabledLogsForProd: true,
      purchaseAmount: 5500.0,
      invoiceId: String(someInvoiceId),
      orderNumber: String(someOrderNumber),
      goods: [goods]
    )

    controller.show(AirbaPayViewController(result: result), sender: controller)
  } else {
    result.submit(FlutterMethodNotImplemented)
  }
}



class OneShotFlutterResult {
  private var result: FlutterResult?
  
  init(_ result: @escaping FlutterResult) {
    self.result = result
  }
  
  func submit(_ data: Any) {
    if (result != nil) {
      result!(data)
      result = nil
    }
  }
}

```

3) Создайте файл ```AirbaPayViewController```

```

import Foundation
import SwiftUI
import AirbaPay

class AirbaPayViewController : UIHostingController<AirbaPayView> {
  private var result: OneShotFlutterResult? = nil
  
  init(
    result: OneShotFlutterResult
  ) {
    var lateSelf: AirbaPayViewController? = nil
    self.result = result
    let navigateCoordinator = AirbaPayCoordinator(
      actionOnCloseProcessing: { r in
        lateSelf?.dismiss(animated: false)
        result.submit(["result": r])
      }
    )
    
    let airbaPayView = AirbaPayView(navigateCoordinator: navigateCoordinator) {}
    
    navigateCoordinator.startProcessing()
    super.init(rootView: airbaPayView)
    lateSelf = self
    view.backgroundColor = UIColor.black.withAlphaComponent(0)
  }
  
  required dynamic init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    result?.submit(["result": false])
  }
  
  override func viewSafeAreaInsetsDidChange() {
    print("safe")
  }
}

```

4) Добавьте в ```AppDelegate```

```
let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

let airbaPayChannel = FlutterMethodChannel(
     name: "com.example.testFlutter/AirbaPayChannel",
     binaryMessenger: controller.binaryMessenger
)
      
airbaPayChannel.setMethodCallHandler({ call, result -> Void in
     handleAirbaPayChannel(self, call, OneShotFlutterResult(result))
})
```




