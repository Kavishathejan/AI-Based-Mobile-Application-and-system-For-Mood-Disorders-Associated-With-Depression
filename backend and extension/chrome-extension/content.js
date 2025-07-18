// List of keywords to detect
const keywords = ['sad songs', 'suicide', 'breakup', 'headache', 'alone', 'sad','depression', 
  'crying', 
  'grief', 
  'loss', 
  'heartbreak', 
  'lonely', 
  'help', 
  'anxiety', 
  'pain', 
  'stress', 
  'overwhelmed', 
  'hopeless', 
  'failure', 
  'hurt', 
  'struggle', 
  'mental health', 
  'self-harm', 
  'isolation', 
  'worthless', 
  'broken',
  'cheat',
  'ugly'
];

/**
 * Check the current page for keywords in the search query.
 */
function checkPageForKeywords() {
  const searchQuery = new URLSearchParams(window.location.search).get('q'); // 'q' is the query parameter for Google searches

  if (searchQuery) {
    console.log('User searched for:', searchQuery);

    // Check if any keyword is found in the search query
    for (const keyword of keywords) {
      if (searchQuery.toLowerCase().includes(keyword.toLowerCase())) {
        console.log(`Keyword "${keyword}" detected in search query`);

        // Send a message to the Service Worker (background.js) to process the keyword detection
        chrome.runtime.sendMessage(
          {
            type: 'keywordDetected',
            keyword: keyword,
            query: searchQuery,
            url: window.location.href, // Send the full URL for context
          },
          (response) => {
            if (chrome.runtime.lastError) {
              console.error('Error communicating with background.js:', chrome.runtime.lastError.message);
            } else if (response?.status === 'Error') {
              console.error('Error from background.js:', response.message);
            } else {
              console.log('Response from background.js:', response);
            }
          }
        );

        break; // Exit the loop after the first matching keyword
      }
    }
  } else {
    console.log('No search query detected on this page.');
  }
}

// Run the check when the page is loaded
checkPageForKeywords();

// Optional: Add a listener for future changes in search queries (useful for single-page applications)
window.addEventListener('load', checkPageForKeywords);
