-- تحسين الأداء: حذف الأشجار والفواكه تلقائياً
local function cleanObject(obj)
    -- التحقق من أن الشيء المضاف موجود داخل مسار Gardens وله علاقة بالزرع
    -- سنعتمد على التحقق من وجود كلمة "Plants" أو "Fruits" في المسار
    if obj:IsA("BasePart") or obj:IsA("Model") or obj:IsA("MeshPart") then
        if obj:FindFirstAncestor("Plants") or obj.Name == "Fruits" then
            task.wait(0.1) -- إنتظار بسيط للتأكد من تحميل الكائن ثم حذفه
            obj:Destroy()
        end
    end
end

-- وظيفة للبحث داخل مجلد Gardens بالكامل
local function startCleaning()
    local gardens = workspace:FindFirstChild("Gardens")
    
    if gardens then
        -- 1. تنظيف الموجود حالياً
        for _, descendant in ipairs(gardens:GetDescendants()) do
            cleanObject(descendant)
        end
        
        -- 2. مراقبة أي شيء جديد يتم إضافته (للتعامل مع الزرع الجديد)
        gardens.DescendantAdded:Connect(function(newDescendant)
            cleanObject(newDescendant)
        end)
        
        print("✅ تم تفعيل سكربت تنظيف اللاغ بنجاح - مراقبة Gardens جارية")
    else
        warn("⚠️ لم يتم العثور على مجلد Gardens في الـ Workspace")
    end
end

-- تشغيل السكربت
task.spawn(startCleaning)
