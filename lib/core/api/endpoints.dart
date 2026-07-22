/// ClickUp API v2 endpoint paths. Base URL is configured on the Dio instance.
class Endpoints {
  static const base = 'https://api.clickup.com/api/v2';

  static const user = '/user';
  // Note: the older `/user/team` path now 404s; the current endpoint is `/team`.
  static const teams = '/team';

  static String teamTasks(String teamId) => '/team/$teamId/task';
  static String teamSpaces(String teamId) => '/team/$teamId/space';
  static String task(String taskId) => '/task/$taskId';
  static String list(String listId) => '/list/$listId';

  static String taskComments(String taskId) => '/task/$taskId/comment';
  static String commentThread(String commentId) => '/comment/$commentId/thread';
  static String comment(String commentId) => '/comment/$commentId';

  static String taskAttachments(String taskId) => '/task/$taskId/attachment';

  static String listMembers(String listId) => '/list/$listId/member';

  // Time tracking
  static String timeEntries(String teamId) => '/team/$teamId/time_entries';
  static String startTimer(String teamId) => '/team/$teamId/time_entries/start';
  static String stopTimer(String teamId) => '/team/$teamId/time_entries/stop';
  static String currentTimer(String teamId) =>
      '/team/$teamId/time_entries/current';
  static String timeEntry(String teamId, String entryId) =>
      '/team/$teamId/time_entries/$entryId';
}
