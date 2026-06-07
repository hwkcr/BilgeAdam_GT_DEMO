Background: Kullanıcı ödeme sayfasına erişir
Given Kullanıcı sisteme giriş yapar
And Kullanıcı ödeme sayfasını açar

Scenario: Kredi Kartı ile ödeme yapıldığında başarılı mesajı alınmalı
when Kullanıcı gecerli kredi kartı bilgilerini girer ve odemeyi onaylar
And Kullanıcı odeme işlemini tamamlar
Then Kullanıcı başarılı ödeme mesajını görmelidir
And Kullanıcının hesabından ödeme tutarı düşülmelidir

Scenario: Debit Kart ile ödeme yapıldığında başarılı mesajı alınmalı
when Kullanıcı gecerli debit kart bilgilerini girer ve odemeyi onaylar
And Kullanıcı odeme işlemini tamamlar
Then Kullanıcı başarılı ödeme mesajını görmelidir
And Kullanıcının hesabından ödeme tutarı düşülmelidir