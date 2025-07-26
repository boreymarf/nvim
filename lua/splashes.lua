local splashes = {
  {
    splash = {
      'окак 🥚',
    },
  },
  {
    splash = {
      'Two trucks having sex',
      'Two trucks having sex',
      'My muscles, my muscles',
      'Involuntarily flex',
    },
  },
  {
    splash = {
      "human... i remember you're genocides...",
    },
  },
  {
    splash = {
      'Play Rain World!',
    },
  },
  {
    splash = {
      'Фарш обратно не провернуть и мясо из котлет не восстановишь.',
    },
  },
  {
    splash = {
      'Еду по шоссе, прям после пивка',
    },
  },
}

local function random_splash()
  math.randomseed(os.time())
  return splashes[math.random(1, #splashes)].splash
end

return {
  random_spash = random_splash,
}
