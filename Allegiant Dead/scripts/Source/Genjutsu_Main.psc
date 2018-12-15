Scriptname Genjutsu_Main extends Quest  

ObjectReference Property Target Auto
Actor[] Property AC Auto
Actor[] Property RA_backup Auto
ReferenceAlias[] Property RA Auto
int Property Limiter Auto
int Property AC_Index Auto
Faction Property PlayerF Auto
Faction Property PlayerF1 Auto
Faction Property PlayerF2 Auto
Faction Property Player Auto
TextureSet Property TS1 Auto
int Property f Auto
Actor Property ACtemp Auto
EffectShader Property ES2 Auto

Event OnInit()
	Call_One()
	Game.GetPlayer().AddToFaction(Player)
	Debug.Notification("Main Started")
EndEvent

Function Call_One()
	If f!=0	
		Call_Backup()
	EndIf
	See_Target()
	Call_Two()
EndFunction

Function Call_Two()
	ChK_Target()
	Call_One()
EndFunction

Function Call_Backup()
	RA[0].ForceRefIfEmpty(Game.GetPlayer())
	If RA[0].GetReference()==Game.GetPlayer()
		int t=0
		While t<=30
			RA[t].ForceRefTo(RA_backup[t])
			If RA_backup[t].IsDead()==0
				RA_backup[t].ResetHealthAndLimbs()
			ElseIf RA_backup[t].IsDead()==1
				RA_backup[t].Resurrect()
			EndIf
			t=t+1
		EndWhile
	Limiter=1	
	EndIf	
EndFunction

Function See_Target()
	Target=Game.GetCurrentCrosshairRef()	
	If Target 
		Actor A=Target as Actor
		If A
			int c=0
			int d=0
			While c<=30 && d==0
				If AC[c].IsHostileToActor(Game.GetPlayer()) && Limiter==1
					int y=0
					While y<=30
					RA[y].GetActorReference().SetRelationshipRank(Game.GetPlayer(),4)
						If RA[y].GetActorReference()!=AC[c]
							RA[y].GetActorReference().SetRelationshipRank(AC[c],-4)	
						EndIf
						y=y+1
					EndWhile
				EndIf
				If AC[c]==A
					d=1
					c=(-1+c)
				EndIf
				c=c+1
			EndWhile
			If d==0
				Limiter=1
				c=(-1+c)
				AC[AC_Index]=A
				Debug.Notification("New Guy Added : "+AC[AC_Index].GetBaseObject().GetName() + " and Index = "+AC_Index)
				ACtemp=AC[AC_Index]
				AC_Index=AC_Index+1
				If AC_Index==31
					AC_Index=0
				EndIf
			ElseIf d==1 && ACtemp!=AC[c]
				Debug.Notification("Same Old Guy Detected : "+AC[c].GetBaseObject().GetName())
				ACtemp=AC[c]
				If Limiter==0
					Limiter=1
				ElseIf Limiter==1
					Limiter=0
				EndIf
			EndIf	
		EndIf
	EndIf
EndFunction

Function Chk_Target()
	int c=0
	int d=0
	int e=0
	While c<=30 && e==0
		If AC[c].IsDead()==1 && AC[c].GetKiller()==Game.GetPlayer()
			While d<=30 && e==0
				If RA[d].GetReference()==AC[c]
					d=(-1+d)
					e=1
				EndIf
				d=d+1
			EndWhile
			If e==0
				d=(-1+d)
				AC[c].Resurrect()
				Game.GetPlayer().PushActorAway(AC[c],0)
				AC[c].RemoveFromAllFactions()
				AC[c].SetCrimeFaction(None)
				AC[c].SetAttackActorOnSight()
				AC[c].SetAV("Aggression",0)
				AC[c].SetAV("HealRate",100)
				AC[c].SetAV("StaminaRate",100)
				AC[c].SetAV("WeaponSpeedMult",1.5)
				AC[c].SetAV("CritChance",100)
				AC[c].disable()
				Utility.Wait(0.5)
				AC[c].Enable()
				AC[c].AddToFaction(PlayerF)
				AC[c].SetFactionRank(PlayerF,0)
				PlayerF.SetAlly(PlayerF,True,True)
				AC[c].AddToFaction(PlayerF1)
				AC[c].AddToFaction(PlayerF2)
				Game.GetPlayer().StopCombatAlarm()
				AC[c].ClearExtraArrows()
				AC[c].SetRelationshipRank(Game.GetPlayer(),4)
				AC[c].SetEyeTexture(TS1)
				AC[c].StopCombatAlarm()
				AC[c].StopCombat()	
				AC[c].MakePlayerFriend()
				AC[c].EvaluatePackage()
				If RA[f].GetReference()!=None	
					RA[f].GetActorReference().RemoveFromAllFactions()
					RA[f].GetActorReference().SetAV("HealRate",10)
					RA[f].GetActorReference().SetAV("StaminaRate",10)
					RA[f].GetActorReference().SetAV("WeaponSpeedMult",1)
					RA[f].GetActorReference().SetRelationshipRank(Game.GetPlayer(),1)
					RA[f].GetActorReference().ClearExtraArrows()
					RA[f].GetActorReference().EvaluatePackage()
					RA[f].GetActorReference().Disable()
					Utility.Wait(0.5)
					RA[f].GetActorReference().Enable()
					RA[f].GetActorReference().Kill()
				EndIf	
				RA[f].ForceRefTo(AC[c])
				RA_backup[f]=AC[c]
				ES2.play(AC[c])
				f=f+1
				If f==31
					f=0
				EndIf
				Debug.Notification("New Man Added : " +AC[c].GetBaseObject().GetName()+" and f = "+f)
			EndIf
		EndIf
		c=c+1
	EndWhile
EndFunction