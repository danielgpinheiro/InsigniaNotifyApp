export const play = (event) => {
  const soundName = event.detail;
  const ctx = new AudioContext();

  if (soundName !== "no-sound") {
    fetch(`/sounds/${soundName}.mp3`)
      .then((data) => data.arrayBuffer())
      .then((arrayBuffer) => ctx.decodeAudioData(arrayBuffer))
      .then((decodedAudio) => {
        const playSound = ctx.createBufferSource();
        playSound.buffer = decodedAudio;
        playSound.connect(ctx.destination);
        playSound.start(ctx.currentTime);
      })
      .catch((e) => {
        console.error(`Error playing audio`, e);
      });
  }
};

const playSound = {
  mounted() {
    window.addEventListener("playSound", (event) => {
      play(event);
    });
  },
};

export default playSound;
