namespace ConsoleApp4.Repository;

public interface IRepository<T> where T : class
{
    //List<T> Search(Predicate<T> condition);
    List<T> Search(Func<T, bool> condition);
}