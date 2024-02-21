## Техническая документация для интеграции sdk AirbaPay в мобильные приложения

## 1.1 Подключение sdk

## 1.2 Вызов стартовой формы

## 1.3 Пример использования

## 1.1  Подключение sdk

Последняя версия 1.0.50

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

Для инициализации sdk нужно выполнить ```AirbaPaySdk.initOnCreate()``` до перехода на страницу, где будет использоваться
sdk)

| Параметр            | Тип              | Обязательный | Описание                                                                        |
|---------------------|------------------|--------------|---------------------------------------------------------------------------------|
| shopId              | String           | да           | ID магазина в системе AirbaPay                                                  |
| password            | String           | да           | Пароль в системе AirbaPay                                                       |
| terminalId          | String           | да           | ID терминала под которым создали платеж                                         |
| lang                | AirbaPaySdk.Lang | да           | Код языка для UI                                                                |
| isProd              | Bool             | да           | Продовская или тестовая среда airbapay                                          |
| phone               | String           | да           | Телефон пользователя                                                            |
| failureCallback     | String           | да           | URL вебхука при ошибке                                                          |
| successCallback     | String           | да           | URL вебхука при успехе                                                          |
| userEmail           | String           | да           | Емейл пользователя, куда будет отправлена квитанция. В случае отсутствия емейла |
| colorBrandMain      | Color            | нет          | Брендовый цвет кнопок, переключателей и текста                                  |
| colorBrandInversion | Color            | нет          | Цвет текста у кнопок с брендовым цветом                                         |
| autoCharge          | Int              | нет          | Автоматическое подтверждение при 2х-стадийном режиме 0 - нет, 1 - да            |
| enabledLogsForProd  | Bool             | нет          | Флаг для включения логов                                                        |

При смене значения isProd, требуется выгрузить приложение из памяти.

Пример:

```

AirbaPaySdk.initOnCreate(
    shopId: "test-merchant",
    password: "123456",
    terminalId: "64216e7ccc4a48db060dd689",
    lang: AirbaPaySdk.Lang.RU(),
    isProd: false, 
    phone: "77051000000",
    failureCallback: "https://site.kz/failure-clb", 
    successCallback: "https://site.kz/success-clb",                
    userEmail: "test@test.com", 
    colorBrandMain: Color.red 
)

```

Перед открытием формы AirbaPay нужно выполнить AirbaPaySdk.initProcessing()

| Параметр           | Тип                                  | Обязательный | Описание                                                                    |
|--------------------|--------------------------------------|--------------|-----------------------------------------------------------------------------|
| purchaseAmount     | Int                                  | да           | Сумма платежа                                                               |
| invoiceId          | String                               | да           | ID платежа в системе магазина                                               | 
| orderNumber        | String                               | да           | Номер заказа в системе магазина                                             |
| goods              | Array<AirbaPaySdk.Goods>             | да           | Список продуктов для оплаты                                                 |
| settlementPayments | Array<AirbaPaySdk.SettlementPayment> | нет          | Распределение платежа по компаниям. В случае одной компании, может быть nil |

Пример:

```
 private func initProcessing(
      invoiceId: String,
      orderNumber: String
 ) {
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

 
       AirbaPaySdk.initProcessing(
           purchaseAmount: 1000,
           invoiceId: invoiceId,
           orderNumber: orderNumber,
           goods: goods,
           settlementPayments: settlementPayment
       )
   }
}

 ```

## 1.2 Вызов стартовой формы

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

 ```
var body: some View {
           AirbaPayView(
                navigateCoordinator: navigateCoordinator,
                contentView: contentView
            )
}
 ```

| Параметр            | Тип                                 | Обязательный | Описание                                      |
|---------------------|-------------------------------------|--------------|-----------------------------------------------|
| navigateCoordinator | @ObservedObject AirbaPayCoordinator | да           | Координатор навигации                         |
| contentView         | AnyView?                            | да           | Контент страницы, на которой будет вызван sdk |



## 1.3 Пример использования

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

                                            AirbaPaySdk.initOnCreate(~~~)
                                            initProcessing(~~~)
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