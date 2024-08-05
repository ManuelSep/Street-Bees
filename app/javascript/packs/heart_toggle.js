document.addEventListener("DOMContentLoaded", () => {
  console.log("DOM fully loaded and parsed");
  document.querySelectorAll('.heart-icon .heart').forEach((heartIcon) => {
    heartIcon.addEventListener('click', (event) => {
      const heart = event.target;
      const isLiked = heart.dataset.liked === 'true';
      console.log("Heart clicked, current state:", isLiked);
      const newSrc = isLiked ? '/assets/heart_empty.png' : '/assets/heart_full.png';
      heart.src = newSrc;
      heart.dataset.liked = !isLiked;
      console.log("New state:", heart.dataset.liked);
    });
  });
});
