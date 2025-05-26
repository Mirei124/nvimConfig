return function()
  require("orgmode").setup({
    org_agenda_files = "~/.config/orgfiles/**/*",
    org_default_notes_file = "~/.config/orgfiles/refile.org",
    org_todo_keywords = { "TODO(t)", "NEXT(n)", "|", "DONE(d)" },
    org_agenda_custom_commands = {
      c = {
        description = "Not scheduled",
        types = {
          {
            type = "tags_todo",
            match = 'TODO="TODO"',
            org_agenda_todo_ignore_scheduled = "all",
          },
          {
            type = "agenda",
            org_agenda_overriding_header = 'Whole week overview',
            org_agenda_span = 'week',
            org_agenda_start_on_weekday = 1,
            org_agenda_remove_tags = true,
          },
        },
      },
    },
  })
end
