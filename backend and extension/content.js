// List of keywords to detect
const keywords = ['sad songs', 'suicide', 'breakup', 'headache', 'alone','sad'];

function checkPageForKeywords() {
  const searchQuery = new URLSearchParams(window.location.search).get('q'); // 'q' is the query parameter for Google searches

  if (searchQuery) {
    console.log('User searched for:', searchQuery);
    
    // Check if any keyword is found in the search query
    for (const keyword of keywords) {
      if (searchQuery.toLowerCase().includes(keyword.toLowerCase())) {
        console.log(`Keyword "${keyword}" detected in search query`);
        
        // Send message to background.js or trigger a notification
        chrome.runtime.sendMessage({
          type: 'keywordDetected',
          keyword: keyword,
          query: searchQuery,
          url: window.location.href
        });
        
        break;
      }
    }
  }
}

// Run the check when the page is loaded
checkPageForKeywords();
