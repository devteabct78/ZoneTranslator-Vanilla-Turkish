-- [GÜNCELLENDİ] Klasör adı değiştiği için font yolu da ZoneTranslator-Vanilla-Turkish olarak ayarlandı.
local fontPath = "Interface\\AddOns\\ZoneTranslator-Vanilla-Turkish\\Fonts\\ipagui.ttf"

local function ApplyTurkishFontToZones()
    -- Eğer Türkçe karakterleri aktif etmek istersen bu yorum satırlarını (--) kaldırabilirsin
    -- MinimapZoneText:SetFont(fontPath, 12)
    -- ZoneTextString:SetFont(fontPath, 32)
    -- SubZoneTextString:SetFont(fontPath, 24)
end

-- ANA ÇEVİRİ VE EKRANA BASMA FONKSİYONU
local function UpdateZoneTexts()
    -- Veritabanı dosyasının yüklendiğinden emin oluyoruz
    if not ZoneTranslator_ZoneData then return; end

    -- A) MİNİMAP ÇEVİRİSİ
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

-- OLAY (EVENT) DİNLEYİCİSİ ÇERÇEVESİ
local ZT_Frame = CreateFrame("Frame")

-- Oyunun bölge isimlerini güncellediği tüm anları (eventleri) yakalaması için kaydediyoruz:
ZT_Frame:RegisterEvent("ZONE_CHANGED")               -- Normal yürüme ile alt bölge değişimi
ZT_Frame:RegisterEvent("ZONE_CHANGED_INDOORS")       -- Han, mağara vb. kapalı mekanlara giriş
ZT_Frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")      -- Ana bölgeler arası geçiş (Örn: Elwynn -> Westfall)
ZT_Frame:RegisterEvent("MINIMAP_ZONE_CHANGED")       -- Sadece minimap'in tetiklendiği özel anlar
ZT_Frame:RegisterEvent("PLAYER_ENTERING_WORLD")      -- Oyuna ilk giriş veya loading ekranı bitişi

-- Event tetiklendiğinde çeviri fonksiyonumuzu çalıştırıyoruz
ZT_Frame:SetScript("OnEvent", function()
    -- Fontu değiştirmek istersen aşağıdaki satırın başındaki yorum işaretini kaldır:
    -- ApplyTurkishFontToZones() 
    
    UpdateZoneTexts()
end)