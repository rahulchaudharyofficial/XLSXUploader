public class ParkLocator {
    public static String[] country(String country) {
        String[] parks = null;
        if(!String.isBlank(country)) {
            ParkService.ParksImplPort service = new ParkService.ParksImplPort();
            parks = service.byCountry(country);
        }
        return parks;
    }
}