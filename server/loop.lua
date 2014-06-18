class 'loop'
function loop:__init()
	self.objects = {}

	--every time you double the iterations, half the angleoffset
	--every time you half the iterations, double the angleoffset
	self.iterations = 125 -- default 125
	self.angleOffset = 0.05 -- default 0.05

	self.width = 0.004 -- default 0.004
	self.position = Vector3(-6511, 209, -3356) -- loop position
	self.angle = Angle(0,0,0) -- loop angle

	self.object = "areaset13.bl/cs_gt-bstraight.lod"
	self.collision = "areaset13.bl/cs_gt_lod1-bstraight_col.pfx"
	
	self:loadloop()

	Events:Subscribe("ModuleUnload", self, self.Unload)
	Events:Subscribe("PlayerSpawn", function(e) e.player:SetPosition(Vector3(-6446, 208, -3420)) return false end)

end

function loop:loadloop()
	for i=1,self.iterations do 
		self.angle.pitch = self.angle.pitch - self.angleOffset
		self.position = self.position + (self.angle * Vector3(i*self.width,0,1))

		obj = StaticObject.Create {
			position = self.position,
			angle = self.angle, 	
			model = self.object,
			collision = self.collision,
			enabled = true,
		}
		table.insert(self.objects, obj)
	end
end

function loop:Unload(args)
	for k, v in pairs(self.objects) do
		v:Remove()
	end
	self.objects = {}
end

loop = loop()

