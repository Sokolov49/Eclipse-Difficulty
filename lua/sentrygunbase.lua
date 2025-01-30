SentryGunBase.DEPLOYEMENT_COST = { 0.65, 0.9, 0.9 }
SentryGunBase.AMMO_MUL = { 2, 3 }

-- Unregister sentry guns to prevent enemies from getting stuck/cheesed
-- Enemies will still shoot sentries but they won't actively path towards them
Hooks:PostHook(SentryGunBase, "setup", "sh_setup", SentryGunBase.unregister)

-- Create table for sixth sense timing data
Hooks:PostHook(SentryGunBase, "init", "eclipse_init", function(self, unit)
	self._state_data = self._state_data or {}
end)

-- Check if sentries can mark
function SentryGunBase:has_marking()
	return self._sentry_marking or false
end

-- Workaround to the normal sentry unregistration
Hooks:PostHook(SentryGunBase, "on_death", "eclipse_sentry_on_death", function(self)
	managers.groupai:state():unregister_marking_sentry(self._unit)
end)

Hooks:PostHook(SentryGunBase, "pre_destroy", "eclipse_sentry_pre_destroy", function(self)
	managers.groupai:state():unregister_marking_sentry(self._unit)
end)