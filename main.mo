import Debug "mo:base/Debug";
import Blob "mo:base/Blob";
import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Error "mo:base/Error";
import Int "mo:base/Int";

actor USBCommunicationUAV {
    // USB iletişim için veri yapısı
    type USBMessage = {
        sender: Text;      // Gönderen İHA kimliği
        recipient: Text;   // Alıcı İHA kimliği
        payload: Blob;     // Gönderilen veri
        timestamp: Nat;    // Zaman damgası
    };

    // USB üzerinden mesaj gönderme fonksiyonu
    public func sendUSBMessage(
        sender: Text, 
        recipient: Text, 
        data: Blob
    ) : async () {
        try {
            // USB bağlantısını simüle etme
            let message : USBMessage = {
                sender = sender;
                recipient = recipient;
                payload = data;
                timestamp = debugTimestamp();
            };

            // Mesajı USB üzerinden gönderme işlemi
            await processUSBTransmission(message);
        } catch (error) {
            Debug.print("USB iletişim hatası: " # Error.message(error));
        };
    };

    // USB üzerinden mesaj alma fonksiyonu
    public func receiveUSBMessage(
        expectedSender: Text
    ) : async ?USBMessage {
        // Gerçek USB alma mekanizması burada simüle edilecek
        // Örnek bir mesaj dönüşü
        let mockMessage : USBMessage = {
            sender = "UAV-001";
            recipient = expectedSender;
            payload = Blob.fromArray([1, 2, 3, 4]);
            timestamp = debugTimestamp();
        };

        ?mockMessage
    };

    // Basit zaman damgası üretme fonksiyonu
    private func debugTimestamp() : Nat {
        let now = Int.abs(1234567); // Int.abs() kullanarak mutlak değer alma
        now
    };

    // USB iletişim işlemini işleyen yardımcı fonksiyon
    private func processUSBTransmission(
        message: USBMessage
    ) : async () {
        Debug.print("USB Mesajı Gönderiliyor:");
        Debug.print("Gönderen: " # message.sender);
        Debug.print("Alıcı: " # message.recipient);
        Debug.print("Veri Boyutu: " # Nat.toText(Blob.toArray(message.payload).size()));
    };
}