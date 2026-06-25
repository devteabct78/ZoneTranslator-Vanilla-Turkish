-- [GÜNCELLENDÝ] Klasör adý deðiþtiði için font yolu da ZoneTranslator-Vanilla-Turkish olarak ayarlandý.
local fontPath = "Interface\\AddOns\\ZoneTranslator-Vanilla-Turkish\\Fonts\\ipagui.ttf"

local function ApplyTurkishFontToZones()
    -- Eðer Türkçe karakterleri aktif etmek istersen bu yorum satýrlarýný (--) kaldýrabilirsin
    -- MinimapZoneText:SetFont(fontPath, 12)
    -- ZoneTextString:SetFont(fontPath, 32)
    -- SubZoneTextString:SetFont(fontPath, 24)
end

-- ANA ÇEVÝRÝ VE EKRANA BASMA FONKSÝYONU
local function UpdateZoneTexts()
    -- Veritabaný dosyasýnýn yüklendiðinden emin oluyoruz
    if not ZoneTranslator_ZoneData then return; end

    -- A) MÝNÝMAP ÇEVÝRÝSÝ
    local miniMapName = GetMinimapZoneText()
    if miniMapName and ZoneTranslator_ZoneData[miniMapName] then
        MinimapZoneText:SetText(ZoneTranslator_ZoneData[miniMapName])
    end

    -- B) EKRAN ORTASI BÜYÜK YAZI (Ana Bölge)
    local zoneName = GetZoneText()
    if zoneName and ZoneTranslator_ZoneData[zoneName] then
        ZoneTextString:SetText(ZoneTranslator_ZoneData[zoneName])
    end

    -- C) EKRAN ORTASI KÜÇÜK YAZI (Alt Bölge)
    local subZoneName = GetSubZoneText()
    if subZoneName and ZoneTranslator_ZoneData[subZoneName] then
        SubZoneTextString:SetText(ZoneTranslator_ZoneData[subZoneName])
    end
end

-- OLAY (EVENT) DÝNLEYÝCÝSÝ ÇERÇEVESÝ
local ZT_Frame = CreateFrame("Frame")

-- Oyunun bölge isimlerini güncellediði tüm anlarý (eventleri) yakalamasý için kaydediyoruz:
ZT_Frame:RegisterEvent("ZONE_CHANGED")               -- Normal yürüme ile alt bölge deðiþimi
ZT_Frame:RegisterEvent("ZONE_CHANGED_INDOORS")       -- Han, maðara vb. kapalý mekanlara giriþ
ZT_Frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")      -- Ana bölgeler arasý geçiþ (Örn: Elwynn -> Westfall)
ZT_Frame:RegisterEvent("MINIMAP_ZONE_CHANGED")       -- Sadece minimap'in tetiklendiði özel anlar
ZT_Frame:RegisterEvent("PLAYER_ENTERING_WORLD")      -- Oyuna ilk giriþ veya loading ekraný bitiþi

-- Event tetiklendiðinde çeviri fonksiyonumuzu çalýþtýrýyoruz
ZT_Frame:SetScript("OnEvent", function()
    -- Fontu deðiþtirmek istersen aþaðýdaki satýrýn baþýndaki yorum iþaretini kaldýr:
    -- ApplyTurkishFontToZones() 
    
    UpdateZoneTexts()
end)