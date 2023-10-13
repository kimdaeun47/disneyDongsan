'use strict';

class Carousel {
  constructor(el) {
    this.el = el;
    this.carouselData = [
      {
        'id': '1',
        'src': 'https://i.ibb.co/WnDyFV0/parade1.jpg',
      },
      {
        'id': '2',
        'src': 'https://i.ibb.co/Jzwj04b/parade2.jpg',
      },
      {
        'id': '3',
        'src': 'https://i.ibb.co/ZzCD2GV/parade3.jpg',
      },
      {
        'id': '4',
        'src': 'https://i.ibb.co/HPTrDtg/parade4.jpg',
      },
      {
        'id': '5',
        'src': 'https://i.ibb.co/sgkz0HS/parade5.jpg',
      }
    ];
    this.carouselInView = [1, 2, 3, 4, 5];
    this.carouselContainer;
    this.carouselPlayState;
    
  }

  mounted() {
    this.setupCarousel();
  }

  // Build carousel html
  setupCarousel() {
    const container = document.createElement('div');
    const controls = document.createElement('div');

    // Add container for carousel items and controls
    this.el.append(container, controls);
    container.className = 'carosel-container';
    controls.className = 'carosel-controls';

    // Take dataset array and append items to container
    this.carouselData.forEach((item, index) => {
      const carouselItem = item.src ? document.createElement('img') : document.createElement('div');

      container.append(carouselItem);
      
      // Add item attributes
      carouselItem.className = `carosel-item carosel-item-${index + 1}`;
      carouselItem.src = item.src;
      carouselItem.setAttribute('loading', 'lazy');
      // Used to keep track of carousel items, infinite items possible in carousel however min 5 items required
      carouselItem.setAttribute('data-index', `${index + 1}`);
    });

    // Set container property
    this.carouselContainer = container;
    
	this.play();
  }

  previous() {
    // Update order of items in data array to be shown in carousel
    this.carouselData.unshift(this.carouselData.pop());

    // Push the first item to the end of the array so that the previous item is front and center
    this.carouselInView.push(this.carouselInView.shift());

    // Update the css class for each carousel item in view
    this.carouselInView.forEach((item, index) => {
      this.carouselContainer.children[index].className = `carosel-item carosel-item-${item}`;
    });

    // Using the first 5 items in data array update content of carousel items in view
    this.carouselData.slice(0, 5).forEach((data, index) => {
      document.querySelector(`.carosel-item-${index + 1}`).src = data.src;
    });
  }

  next() {
    // Update order of items in data array to be shown in carousel
    this.carouselData.push(this.carouselData.shift());

    // Take the last item and add it to the beginning of the array so that the next item is front and center
    this.carouselInView.unshift(this.carouselInView.pop());

    // Update the css class for each carousel item in view
    this.carouselInView.forEach((item, index) => {
      this.carouselContainer.children[index].className = `carosel-item carosel-item-${item}`;
    });

    // Using the first 5 items in data array update content of carousel items in view
    this.carouselData.slice(0, 5).forEach((data, index) => {
      document.querySelector(`.carosel-item-${index + 1}`).src = data.src;
    });
  }
  

  play() {
	  const startPlaying = () => this.next();
	  // First run initial next method
      this.next();

      // Use play state prop to store interval ID and run next method on a 1.5 second interval
      this.carouselPlayState = setInterval(startPlaying, 3000);
      
  }

}

// Refers to the carousel root element you want to target, use specific class selectors if using multiple carousels
const el = document.querySelector('.carosel');
// Create a new carousel object
const exampleCarousel = new Carousel(el);
// Setup carousel and methods
exampleCarousel.mounted();
