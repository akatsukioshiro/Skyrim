Scriptname Genjutsu_RingScript extends ActiveMagicEffect  

EffectShader Property Effect Auto

Event OnEffectStart(Actor Target, Actor Caster)
	Effect.Play(Caster)
EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)
	Effect.Stop(Caster)
EndEvent
