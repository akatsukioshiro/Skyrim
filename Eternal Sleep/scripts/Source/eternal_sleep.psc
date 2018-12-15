Scriptname eternal_sleep extends ActiveMagicEffect  

Spell Property M  Auto
ObjectReference Property X  Auto
Armor Property helm  Auto
EffectShader Property Shade Auto
EffectShader Property Ooze Auto

Event OnEffectStart(Actor Target, Actor Caster)
	int u=-100
	int c=0
	int d=0
	X.MoveTo(Caster,10000)
	X.Enable()
	While Target.IsDead()==0 && d==0
		X.SetPosition(Target.GetPositionX()+100,Target.GetPositionY()+100,Target.GetPositionZ()+10)
		M.RemoteCast(X, Target, Target)
		X.SetPosition(Target.GetPositionX()+u,Target.GetPositionY()+u,Target.GetPositionZ()+100)
		M.RemoteCast(X, Target, Target)
		X.SetPosition(Target.GetPositionX()+100,Target.GetPositionY()+u,Target.GetPositionZ()+10)
		M.RemoteCast(X, Target, Target)
		X.SetPosition(Target.GetPositionX()+u,Target.GetPositionY()+100,Target.GetPositionZ()+100)
		M.RemoteCast(X, Target, Target)
		
		X.SetPosition(Target.GetPositionX()+100,Target.GetPositionY()+100,Target.GetPositionZ()+100)
		M.RemoteCast(X, Target, Target)
		X.SetPosition(Target.GetPositionX()+u,Target.GetPositionY()+u,Target.GetPositionZ()+10)
		M.RemoteCast(X, Target, Target)
		X.SetPosition(Target.GetPositionX()+100,Target.GetPositionY()+u,Target.GetPositionZ()+100)
		M.RemoteCast(X, Target, Target)
		X.SetPosition(Target.GetPositionX()+u,Target.GetPositionY()+100,Target.GetPositionZ()+10)
		M.RemoteCast(X, Target, Target)
		c=c+1
		If c<=2 && Target.IsEssential()==0
			Target.Kill()
		ElseIf c==3 
			If Target.GetFlyingState() == 0
				Caster.PushActorAway(Target, 0)
				Target.SetActorValue("Paralysis",1)
				Target.SetUnconscious(true)
			ElseIf Target.IsEssential()==1 && (Target.GetFlyingState() == 1||Target.GetFlyingState() == 2||Target.GetFlyingState() == 3||Target.GetFlyingState() == 4)
				Target.Kill()
				Target.KillEssential()
				
			EndIf	
			d=d+1
		EndIf
		

	EndWhile
	Target.EquipItem(helm)
	Shade.Play(Target,3.0)
	Ooze.Play(Target,4.0)
	X.Disable()
	
EndEvent

