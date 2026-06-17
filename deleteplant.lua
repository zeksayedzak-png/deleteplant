-- سكربت تنظيف جميع الـ Plots (من 1 إلى 10) وحذف الأشجار والفواكه نهائياً
print("🧹 تم تفعيل منظف المزارع الشامل... جارِ تنظيف Plot 1-10")

local gardens = workspace:WaitForChild("Gardens")

-- وظيفة الفحص والحذف
local function cleanPlantOrFruit(obj)
    -- التحقق من أن الكائن جزء من شجرة أو فاكهة
    -- نبحث عن أي كائن يكون أبوه أو جده اسمه "Plants" أو "Fruits"
    local isPlantRelated = obj:FindFirstAncestor("Plants") or obj:FindFirstAncestor("Fruits")
    
    if isPlantRelated then
        -- إذا وجدنا أي جزء (Part, Model, Mesh) ينتمي للزرع، نحذفه
        if obj:IsA("BasePart") or obj:IsA("Model") or obj:IsA("MeshPart") then
            -- ننتظر لحظة صغيرة جداً لضمان عدم حدوث خطأ في السيرفر ثم نحذف
            task.wait() 
            obj:Destroy()
        end
    end
end

-- 1. تنظيف الماب فور تشغيل السكربت (المسح الأولي)
-- سيبحث في Gardens وكل الـ Plots التي بداخلها
for _, item in ipairs(gardens:GetDescendants()) do
    cleanPlantOrFruit(item)
end

-- 2. المراقبة التلقائية (الرادار)
-- أي شجرة أو فاكهة تظهر في أي Plot من الـ 10، سيتم رصدها وحذفها فوراً
gardens.DescendantAdded:Connect(function(newItem)
    cleanPlantOrFruit(newItem)
end)

-- إضافة اختيارية: حذف التأثيرات الضوئية والجزيئات لتقليل اللاغ لأقصى درجة
gardens.DescendantAdded:Connect(function(effect)
    if effect:IsA("ParticleEmitter") or effect:IsA("Trail") or effect:IsA("Sparkles") then
        effect:Destroy()
    end
end)

print("✅ الرادار يعمل الآن: يتم مراقبة وحذف أي زرع جديد في جميع المزارع.")
