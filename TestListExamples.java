import static org.junit.Assert.*;
import java.util.List;
import java.util.Arrays;
import org.junit.*;

public class TestListExamples {
  @Test(timeout=100)
  public void shouldCreate() {
    ListExamples example = new ListExamples();
  }
  @Test(timeout=100)
  public void shouldFilter() {
    List<String> expected = Arrays.asList(
        new String[] {
          "apple",
          "apple computer",
        });
    List<String> haystack = Arrays.asList(
        new String[] {
          "apple",
          "banana",
          "banana computer",
          "apple computer",
        });

    List<String> filtered = ListExamples.filter(haystack, (String s) -> s.contains("apple"));

    assertEquals(expected, filtered);
  }
  @Test(timeout=100)
  public void shouldMerge() {
    List<String> expected = Arrays.asList(
        new String[] {
          "apple",
          "apple computer",
          "banana",
          "banana computer",
        });
    List<String> fruits = Arrays.asList(
        new String[] {
          "apple",
          "banana",
        });
    List<String> companies = Arrays.asList(
        new String[] {
          "apple computer",
          "banana computer",
        });

    List<String> actual = ListExamples.merge(fruits, companies);
    assertEquals(expected, actual);
  }
  @Test(timeout=100)
  public void shouldMergeWithSameValue() {
    List<String> expected = Arrays.asList(
        new String[] {
          "apple",
          "apple",
          "banana",
          "banana",
        });
    List<String> fruits = Arrays.asList(
        new String[] {
          "apple",
          "banana",
        });

    List<String> actual = ListExamples.merge(fruits, fruits);
    assertEquals(expected, actual);
  }
}
