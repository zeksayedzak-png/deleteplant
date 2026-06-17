-- سكربت التنظيف الفوري والمراقبة المستمرة
print("🚀 جاري المسح الشامل والفوري لجميع المزارع...")

local gardens = workspace:WaitForChild("Gardens")

-- 1. المسح الفوري (دفعة واحدة)
-- هذا الجزء سيمر على كل Plot ويفرغ مجلد Plants فوراً
local function instantPurge()
    for _, plot in ipairs(gardens:GetChildren()) do
        local plantsFolder = plot:FindFirstChild("Plants")
        if plantsFolder then
            -- حذف كل محتويات مجلد Plants دفعة واحدة
            plantsFolder:ClearAllChildren()
        end
    end
    print("🧹 تمت عملية المسح الأولي بنجاح!")
end

-- 2. وظيفة المراقبة والحذف اللحظي
-- أي شيء يضاف لاحقاً سيتم حذفه قبل أن يراه المعالج (GPU)
local function handleNewObject(obj)
    -- إذا تم إضافة شيء داخل مجلد اسمه Plants أو Fruits، احذفه فوراً
    if obj:FindFirstAncestor("Plants") or obj:FindFirstAncestor("Fruits") or obj.Name == "Plants" or obj.Name == "Fruits" then
        -- نستخدم الحذف المباشر بدون إنتظار
        obj:Destroy()
    end
end

-- تشغيل المسح الفوري أولاً
instantPurge()

-- تفعيل المراقبة لكل المزارع (Plot 1-10)
gardens.DescendantAdded:Connect(handleNewObject)

-- إضافة: حذف أي جزيئات أو تأثيرات لاج تظهر في الماب بشكل عام
workspace.DescendantAdded:Connect(function(item)
    if item:IsA("ParticleEmitter") or item:IsA("Trail") then
        item:Destroy()
    end
end)
