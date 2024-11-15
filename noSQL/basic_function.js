db.Book.aggregate([
  {
    // Filter to include only approved books
    $match: {
      isApproved: true
    }
  },
  {
    // Group by author and count the number of books
    $group: {
      _id: "$author",
      count: {
        $sum: 1
      }
    }
  },
  {
    // Sort by order of the author's books amount
    $sort:
      {
        count: -1,
        _id: 1
      }
  },
  {
    // Rename all field to author for output consistency
    $project: {
      _id: 0,
      author: "$_id",
      count: "$count"
    }
  }
])