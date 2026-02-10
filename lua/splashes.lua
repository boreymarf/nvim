local splashes = {
  {
    -- Local meme
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
      -- Undertale meme
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
      -- Цитата
      'Фарш обратно не провернуть и мясо из котлет не восстановишь.',
    },
  },
  {
    splash = {
      -- Deltarune meme 2025
      'Еду по шоссе, прям после пивка',
    },
  },
  {
    splash = {
      -- Ваши храбрые соседи - Самоуправление - а не самодержавие
      'Не бросайте окурки на пол, тараканы могут заболеть раком!',
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
