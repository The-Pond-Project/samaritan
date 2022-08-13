const recordButton = document.getElementById('ripple-record-button')

const geoLocate = (position) => {
  const latitude = position.coords.latitude
  const longitude = position.coords.longitude
  document.getElementById('ripple_latitude').value = latitude;
  document.getElementById('ripple_longitude').value = longitude;
  document.forms.new_ripple.submit();
}

const handleError = (error) => {
  if (error.code == error.PERMISSION_DENIED) {
      document.forms.new_ripple.submit();
  };
}

recordButton.addEventListener('click', (event) => {
  event.preventDefault();
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(geoLocate, handleError);
  }
});