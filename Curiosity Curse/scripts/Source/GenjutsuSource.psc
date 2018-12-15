Scriptname GenjutsuSource extends ActiveMagicEffect  

Armor Property Rings Auto
Armor Property SuiteUpB Auto
Armor Property SuiteUpG Auto
Armor Property SuiteUpH Auto
Armor Property SuiteUpR Auto
Armor Property SuiteB Auto
Armor Property SuiteG Auto
Armor Property SuiteH Auto
Armor Property SuiteC Auto
Actor Property Vict Auto
Faction Property FealtyF Auto
ReferenceAlias[] Property Fealtification Auto
Genjutsu_Count Property FC auto

Function OnEffectStart(Actor Target, Actor Caster)
int set=0
int last=0
If Target==None
	set=5
ElseIf Target.IsInFaction(FealtyF)==0 && Target.IsEquipped(Rings)
	int cnt=0
	int y=0
		While y==0 && cnt<=30
			Actor thisPerson = Fealtification[cnt].GetActorReference()
			If Target==thisPerson
				Target.RemoveAllItems()
				last=FC.FealtyMemberCount
				If last==0 
					last=30
				ElseIf last!=0
					last=(-1+last)
				EndIf
				If Vict.IsDead()==1
					Vict.resurrect()
				EndIf
				Actor lastPerson = Fealtification[last].GetActorReference()
				Fealtification[last].Clear()
				Fealtification[cnt].ForceRefTo(lastPerson)
				FC.FealtyMemberCount=last
				Target.RemoveFromFaction(FealtyF)
				Target.Resurrect()
				Debug.Notification("Genjutsu released !")
				set=1
				y=1
			EndIf
			cnt=cnt+1
		EndWhile
	Target.EvaluatePackage()
	RegisterForSingleUpdate(0.25)
EndIf
If Caster.IsInFaction(FealtyF)==0
	Caster.AddToFaction(FealtyF)
EndIf
While set<=1
	If set==1
		Fealtification[last].ForceRefTo(Vict)
	ElseIf Target.IsInFaction(FealtyF)==0 && FC.FealtyMemberCount<=30
		Target.AddToFaction(FealtyF)
		Target.StopCombat()
		Target.IgnoreFriendlyHits()
		Fealtification[FC.FealtyMemberCount].ForceRefTo(Target)
		FC.FealtyMemberCount=FC.FealtyMemberCount+1
		Dress(Target)
		Debug.Notification("Genjutsu activated !")
		set=5
	ElseIf Target.IsInFaction(FealtyF)==1 && FC.FealtyMemberCount<=30
		int y=0 
		int cnt=0
		While y==0 && cnt<=30
			Actor thisPerson = Fealtification[cnt].GetActorReference()
			If Target==thisPerson
				Target.RemoveAllItems()
				last=FC.FealtyMemberCount
				If last==0 
					last=30
				ElseIf last!=0
					last=(-1+last)
				EndIf
				If Vict.IsDead()==1
					Vict.resurrect()
				EndIf
				Actor lastPerson = Fealtification[last].GetActorReference()
				Fealtification[last].Clear()
				Fealtification[cnt].ForceRefTo(lastPerson)
				FC.FealtyMemberCount=last
				Target.RemoveFromFaction(FealtyF)
				Target.Resurrect()
				Debug.Notification("Genjutsu released !")
				y=1
			EndIf
			cnt=cnt+1
		EndWhile
		If y!=1
			Debug.Notification("Failed")
		EndIf
	EndIf
	Target.EvaluatePackage()
	RegisterForSingleUpdate(0.25)
	set=set+1
EndWhile
If FC.FealtyMemberCount>=31
	FC.FealtyMemberCount=0
EndIf
;int num=30
;int total=0
;While num>=0
;	Fealtification[num].ForceRefIfEmpty(Vict)
;	Actor currentPerson = Fealtification[num].GetActorReference()
;	If currentPerson!=Vict
;		total=total+1
;		num=(-1+num)
;	ElseIf currentPerson==Vict && num!=0
;		Fealtification[num].Clear()
;		num=(-1+num)
;	ElseIf currentPerson==Vict && num==0
;		;
;	EndIf
;EndWhile		
;Debug.Notification(total+" Under control.")
EndFunction

Function Dress(Actor T)
ActorBase TT = T.GetActorBase()
T.RemoveAllItems()
If (TT.GetSex() == 1)
	T.EquipItem(SuiteUpB)
	T.EquipItem(SuiteUpG)
	T.EquipItem(SuiteUpH)
	T.EquipItem(SuiteUpR)
ElseIf (TT.GetSex() == 0)
	T.EquipItem(SuiteB)
	T.EquipItem(SuiteG)
	T.EquipItem(SuiteH)
	T.EquipItem(SuiteC)
EndIf	
T.EquipItem(Rings)
EndFunction
